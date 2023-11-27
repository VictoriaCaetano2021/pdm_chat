import 'package:flutter/material.dart';
import '../banco/banco.dart';
class Comentario {
  String texto;
  int id;

  Comentario({required this.texto, required this.id});
}

class PaginaUsuario extends StatefulWidget {
  final String login;
  final String senha;
  final int idUser;

  PaginaUsuario({required this.login, required this.senha, required this.idUser});

  @override
  _PaginaUsuarioState createState() => _PaginaUsuarioState();
}

class _PaginaUsuarioState extends State<PaginaUsuario> {
  List<Comentario> comentarios = [];
  

  @override
  void initState() {
    super.initState();
    buscarComentarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              adicionarComentario(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 8.0),
            Text(
              widget.login,
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: comentarios.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListTile(
                      title: Text(
                        comentarios[index].texto,
                        style: TextStyle(fontSize: 16.0),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              editarComentario(context, comentarios[index]);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              excluirComentario(context, comentarios[index]);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void buscarComentarios() async {
    Banco banco = Banco(falhaConexao);

    String consulta =
        "SELECT id_comment, comment_text FROM tb_comment WHERE id_user = ${widget.idUser} and use_flag='Y'";

    await banco.query(consulta, (numRegistros, result) {
      if (numRegistros > 0) {
        setState(() {
          comentarios = result!.map<Comentario>((registro) {
            String texto = registro["tb_comment"]["comment_text"].toString();
            int id = registro["tb_comment"]["id_comment"] as int;
            return Comentario(texto: texto, id: id);
          }).toList();
        });
      } else {
        //isso esta funcionando?????
        print("Nenhum comentário encontrado.");
        comentarios = [];

        //isso aqui não cria um loop infinito não????
          // MaterialPageRoute(
          //   builder: (context) => PaginaUsuario(
          //     login: widget.login,
          //     senha: widget.senha,
          //     idUser: widget.idUser,
          //   ),
          // );
      }
    }, falhaConexao);

    await banco.fecha();
  }

  void editarComentario(BuildContext context, Comentario comentario) async {
    TextEditingController controller = TextEditingController(text: comentario.texto);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar Comentário'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: 'Digite a edição do comentário',
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Salvar'),
              onPressed: () async {
                String novoTexto = controller.text;

                // setState(() {
                //   comentario.texto = novoTexto;
                // });

                Banco bancoUpdate = Banco(falhaConexao);
                String update = "UPDATE tb_comment SET use_flag = 'N' WHERE id_comment = ${comentario.id};";
                print(update);
                await bancoUpdate.query(update, (numRegistros, result) {buscarComentarios();}, falhaConexao);
                await bancoUpdate.fecha();

                Banco bancoInsert = Banco(falhaConexao);
                String insert = "INSERT INTO tb_comment (comment_text, id_user, use_flag) VALUES ('$novoTexto', ${widget.idUser}, 'Y');";
                print(insert);
                await bancoInsert.query(insert, (numRegistros, result) { buscarComentarios();}, falhaConexao);
                await bancoInsert.fecha();

                Navigator.of(context).pop();
                
              },
            ),
          ],
        );
      },
    );
  }

  void excluirComentario(BuildContext context, Comentario comentario) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Excluir Comentário'),
          content: Text('Deseja realmente excluir o comentário?'),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Excluir'),
              onPressed: () async {
                Banco banco = Banco(falhaConexao);
                String delete = "update tb_comment set use_flag='N' WHERE id_comment = ${comentario.id};";
                print(delete);
                await banco.query(delete, (numRegistros, result) 
                {
                  setState(() {
                    comentarios.remove(comentario); // Remover o comentário pra não aparecer mais na tela
                  });
                  buscarComentarios();
                }, falhaConexao);
                await banco.fecha();

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void adicionarMensagem() async{
    
  }

  void adicionarComentario(BuildContext context) async {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Adicionar Comentário'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: 'Digite o comentário',
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Adicionar'),
              onPressed: () async {
                String texto = controller.text;

                Banco banco = Banco(falhaConexao);
                String insert = "INSERT INTO tb_comment (comment_text, id_user, use_flag) VALUES ('$texto', ${widget.idUser}, 'Y');";
                print(insert);
                await banco.query(insert, (numRegistros, result) {buscarComentarios();}, falhaConexao);
                await banco.fecha();

                //assim eu não tenho que buscar novamente os comentario, ja mostro na tela - deu ruim esta conflitando com os outros comentarios
                // setState(() {
                //   comentarios.add(Comentario(texto: texto, id: 0));
                // });

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void falhaConexao(e) {
    print("Não foi possível conectar-se ao banco - $e");
  }
}