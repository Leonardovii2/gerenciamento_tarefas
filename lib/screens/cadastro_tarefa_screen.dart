import 'package:flutter/material.dart';

import '../models/tarefa.dart';
import '../services/firebase_service.dart';

class CadastroTarefaScreen extends StatefulWidget {
  final Tarefa? tarefa;

  const CadastroTarefaScreen({super.key, this.tarefa});

  @override
  State<CadastroTarefaScreen> createState() => _CadastroTarefaScreenState();
}

class _CadastroTarefaScreenState extends State<CadastroTarefaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();

  final FirebaseService _firebaseService = FirebaseService();

  Tarefa? tarefaEdicao;
  DateTime? _dataVencimento;
  String _prioridade = 'Média';
  bool _carregando = false;

  static const verdeEscuro = Color(0xFF047857);
  static const verdePrincipal = Color(0xFF10B981);
  static const verdeClaro = Color(0xFF34D399);
  static const verdeBarraEscura = Color(0xFF065F46);

  @override
  void initState() {
    super.initState();

    tarefaEdicao = widget.tarefa;

    if (tarefaEdicao != null) {
      _tituloController.text = tarefaEdicao!.titulo;
      _descricaoController.text = tarefaEdicao!.descricao;
      _dataVencimento = tarefaEdicao!.dataVencimento;
      _prioridade = tarefaEdicao!.prioridade;
    }
  }

  Future<void> selecionarData() async {
    final tema = Theme.of(context);
    final modoEscuro = tema.brightness == Brightness.dark;

    final hoje = DateTime.now();
    final dataInicial = _dataVencimento ?? hoje;

    final corPrimaria = modoEscuro ? verdeClaro : verdeEscuro;
    final corTextoPrimario = modoEscuro
        ? const Color(0xFF064E3B)
        : Colors.white;

    final data = await showDatePicker(
      context: context,
      initialDate: dataInicial.isBefore(hoje) ? hoje : dataInicial,
      firstDate: hoje,
      lastDate: DateTime(2035),
      builder: (context, child) {
        return Theme(
          data: tema.copyWith(
            colorScheme: tema.colorScheme.copyWith(
              primary: corPrimaria,
              onPrimary: corTextoPrimario,
              secondary: verdePrincipal,
              onSecondary: Colors.white,
              surface: tema.colorScheme.surface,
              onSurface: tema.colorScheme.onSurface,
            ),
            datePickerTheme: DatePickerThemeData(
              headerBackgroundColor: corPrimaria,
              headerForegroundColor: corTextoPrimario,
              todayForegroundColor: WidgetStatePropertyAll(corPrimaria),
              todayBorder: BorderSide(color: corPrimaria),
            ),
          ),
          child: child!,
        );
      },
    );

    if (data != null) {
      setState(() {
        _dataVencimento = data;
      });
    }
  }

  Future<void> salvarTarefa() async {
    if (!_formKey.currentState!.validate()) return;

    if (_dataVencimento == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione a data de vencimento.')),
      );
      return;
    }

    setState(() {
      _carregando = true;
    });

    try {
      final tarefa = Tarefa(
        id:
            tarefaEdicao?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        titulo: _tituloController.text.trim(),
        descricao: _descricaoController.text.trim(),
        dataVencimento: _dataVencimento!,
        prioridade: _prioridade,
        concluida: tarefaEdicao?.concluida ?? false,
      );

      if (tarefaEdicao == null) {
        await _firebaseService.cadastrarTarefa(tarefa);
      } else {
        await _firebaseService.editarTarefa(tarefa);
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            tarefaEdicao == null
                ? 'Tarefa cadastrada com sucesso!'
                : 'Tarefa atualizada com sucesso!',
          ),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Erro ao salvar tarefa: $e')));
    } finally {
      if (mounted) {
        setState(() {
          _carregando = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final cores = tema.colorScheme;
    final modoEscuro = tema.brightness == Brightness.dark;

    final corPrimaria = modoEscuro ? verdeClaro : verdeEscuro;
    final corTextoBotao = modoEscuro ? const Color(0xFF064E3B) : Colors.white;

    return Scaffold(
      backgroundColor: tema.scaffoldBackgroundColor,

      appBar: AppBar(
        title: Text(
          tarefaEdicao == null ? 'Nova Tarefa' : 'Editar Tarefa',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: modoEscuro ? verdeBarraEscura : verdeEscuro,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // TÍTULO
              TextFormField(
                controller: _tituloController,
                style: TextStyle(color: cores.onSurface),
                decoration: InputDecoration(
                  labelText: 'Título',
                  prefixIcon: Icon(Icons.title, color: corPrimaria),
                  border: const OutlineInputBorder(),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Informe o título.';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // DESCRIÇÃO
              TextFormField(
                controller: _descricaoController,
                maxLines: 3,
                style: TextStyle(color: cores.onSurface),
                decoration: InputDecoration(
                  labelText: 'Descrição',
                  prefixIcon: Icon(Icons.description, color: corPrimaria),
                  alignLabelWithHint: true,
                  border: const OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),

              // DATA DE VENCIMENTO
              Container(
                decoration: BoxDecoration(
                  color: tema.cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: cores.outline.withOpacity(0.5)),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  leading: Icon(Icons.calendar_month, color: corPrimaria),
                  title: Text(
                    _dataVencimento == null
                        ? 'Selecione a data de vencimento'
                        : 'Vencimento: '
                              '${_dataVencimento!.day}/'
                              '${_dataVencimento!.month}/'
                              '${_dataVencimento!.year}',
                    style: TextStyle(color: cores.onSurface),
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: cores.onSurface.withOpacity(0.6),
                  ),
                  onTap: selecionarData,
                ),
              ),

              const SizedBox(height: 16),

              // PRIORIDADE
              DropdownButtonFormField<String>(
                initialValue: _prioridade,
                dropdownColor: cores.surface,
                iconEnabledColor: corPrimaria,
                style: TextStyle(color: cores.onSurface, fontSize: 16),
                decoration: InputDecoration(
                  labelText: 'Prioridade',
                  prefixIcon: Icon(Icons.flag, color: corPrimaria),
                  border: const OutlineInputBorder(),
                ),
                items: [
                  DropdownMenuItem(
                    value: 'Baixa',
                    child: Text(
                      'Baixa',
                      style: TextStyle(color: cores.onSurface),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Média',
                    child: Text(
                      'Média',
                      style: TextStyle(color: cores.onSurface),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Alta',
                    child: Text(
                      'Alta',
                      style: TextStyle(color: cores.onSurface),
                    ),
                  ),
                ],
                onChanged: (valor) {
                  if (valor != null) {
                    setState(() {
                      _prioridade = valor;
                    });
                  }
                },
              ),

              const SizedBox(height: 24),

              // BOTÃO SALVAR
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: corPrimaria,
                    foregroundColor: corTextoBotao,
                    disabledBackgroundColor: corPrimaria.withOpacity(0.5),
                    disabledForegroundColor: corTextoBotao,
                  ),
                  onPressed: _carregando ? null : salvarTarefa,
                  child: _carregando
                      ? SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: corTextoBotao,
                          ),
                        )
                      : Text(
                          tarefaEdicao == null
                              ? 'Salvar Tarefa'
                              : 'Atualizar Tarefa',
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
