package brandaoti.sistema.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.transaction.Transactional;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import brandaoti.sistema.dao.CategoriaDao;
import brandaoti.sistema.dao.PerfilDao;
import brandaoti.sistema.dao.ProdutoDao;
import brandaoti.sistema.dao.UsuarioDao;
import brandaoti.sistema.dao.VendaDao;
import brandaoti.sistema.excel.Tabela;
import brandaoti.sistema.model.Categoria;
import brandaoti.sistema.model.Perfil;
import brandaoti.sistema.model.Produto;
import brandaoti.sistema.model.Usuario;
import brandaoti.sistema.model.Venda;



@Transactional
@Controller
@RequestMapping("/")
public class SistemaController {
	public static String nome = null;
	public static String alerta = null;
	public static String boasVindas = "Bem vindo!";
	public static String usuarioSessao = null;
	public static Usuario usuarioIdSessao = new Usuario();
	public static String senhaSessao = null;
	public static Perfil perfilSessao = null;
	public static Boolean logado = false;
	public static String atualizarPagina = null;
	public static String mensagem = "";
	public static String tituloMensagem = "";
	public static String tipoMensagem = "";
	
	@Autowired
	private UsuarioDao usuarioDao;
	@Autowired
	private PerfilDao perfilDao;
	@Autowired
	private ProdutoDao produtoDao;
	@Autowired
	private CategoriaDao categoriaDao;
	@Autowired
	private VendaDao vendaDao;
	
	public String verificaLink(String link) {
		atualizarPagina = null;
		String direcao = "/pages/deslogar";
		if(logado) {
			direcao = link;
		} else {
			direcao = "/pages/deslogar";
		}
		return direcao;
	}
	
	public ModelAndView verificarSessao(ModelAndView modelAndView) {
		logado = false;
		if(usuarioSessao == null) {
			logado = false;
			modelAndView.addObject("boasVindas", boasVindas);
		}
		else {
			logado = true;
			modelAndView.addObject("boasVindas", boasVindas);
			modelAndView.addObject("perfilSessao", perfilSessao);
		}
		return modelAndView;
	}
	
	public ModelAndView enviaMsg(ModelAndView modelAndView) {
		modelAndView.addObject("mensagem", mensagem);
		modelAndView.addObject("tituloMensagem", tituloMensagem);
		modelAndView.addObject("tipoMensagem", tipoMensagem);
		mensagem = null;
		tituloMensagem = null;
		tipoMensagem = null;
		return modelAndView;
	}
	
	public void registraMsg(String titulo, String msg, String tipo) {
		tituloMensagem = titulo;
		mensagem = msg;
		tipoMensagem = tipo;
	}
	
	@RequestMapping(value = "/deslogar", method = {RequestMethod.POST, RequestMethod.GET}) // Link que ir� acessar...
	public ModelAndView deslogar() { //Fun��o e alguns valores que recebe...
		ModelAndView modelAndView = new ModelAndView("/pages/deslogar"); //JSP que ir� acessar
		nome = null;
		usuarioSessao = null;
		senhaSessao = null;
		perfilSessao = null;
		logado = false;
		return modelAndView; //retorna a variavel
	}
	
	@RequestMapping(value = {"/index","/"}, method = {RequestMethod.POST, RequestMethod.GET}) // Link que ir� acessar...
	public ModelAndView login() { //Fun��o e alguns valores que recebe...
		ModelAndView modelAndView = new ModelAndView("/index"); //JSP que ir� acessar
		usuarioSessao = null;
		senhaSessao = null;
		perfilSessao = null;
		logado = false;
		
		if(categoriaDao.findAll().size() == 0) {
			Categoria c = new Categoria();
			c.setAtivo(true);
			c.setCodigo("1");
			c.setDescricao("Salgados");
			categoriaDao.save(c);
			c = new Categoria();
			c.setAtivo(true);
			c.setCodigo("2");
			c.setDescricao("Doces");
			categoriaDao.save(c);
			c = new Categoria();
			c.setAtivo(true);
			c.setCodigo("3");
			c.setDescricao("Bebidas");
			categoriaDao.save(c);
		}
		
		if(perfilDao.findAll().size() == 0) {
			Perfil p = new Perfil();
			p.setAdmin(true);
			p.setAtivo(true);
			p.setCliente(false);
			p.setCodigo("1");
			p.setDescricao("Admnistrador");
			p.setFuncionario(false);
			p.setVisitante(false);
			perfilDao.save(p);
			
			p = new Perfil();
			p.setAdmin(false);
			p.setAtivo(true);
			p.setCliente(false);
			p.setCodigo("2");
			p.setDescricao("Funcionário");
			p.setFuncionario(true);
			p.setVisitante(false);
			perfilDao.save(p);
			
			p = new Perfil();
			p.setAdmin(false);
			p.setAtivo(true);
			p.setCliente(true);
			p.setCodigo("3");
			p.setDescricao("Cliente");
			p.setFuncionario(false);
			p.setVisitante(false);
			perfilDao.save(p);
			
			p = new Perfil();
			p.setAdmin(false);
			p.setAtivo(true);
			p.setCliente(false);
			p.setCodigo("4");
			p.setDescricao("Visitante");
			p.setFuncionario(false);
			p.setVisitante(true);
			perfilDao.save(p);
			
			//Excluir **********
			if(usuarioDao.findAll().size() == 0) {
				Usuario u = new Usuario();
				u.setAtivo(true);
				u.setCodigo("12345");
				u.setEmail("admin@admin.com");
				u.setLogin("adm");
				u.setNome("Henrique");
				u.setSenha("adm");
				Perfil pe = new Perfil();
				pe = perfilDao.buscarAdm().get(0);
				u.setPerfil(pe);
				usuarioDao.save(u);
			}
			//Excluir **********
			
		}
		
		
		modelAndView.addObject("alerta", alerta); // Variavel que ira mandar
		return modelAndView; //retorna a variavel
	}
	
	@RequestMapping(value = "/adm/home", method = {RequestMethod.POST, RequestMethod.GET}) // Link que ir� acessar...
	public ModelAndView logar(String usuarioVal, String senhaVal) { //Fun��o e alguns valores que recebe...
		String link = "/pages/deslogar";
		if(usuarioSessao == null) {
			link = "/pages/deslogar";
			if(usuarioVal != null || senhaVal != null) {
				Usuario usuario = usuarioDao.findByLoginAndPassword(usuarioVal, senhaVal);
				if(usuario != null) {
					usuarioSessao = usuario.getNome();
					usuarioIdSessao = usuario;
					perfilSessao = usuario.getPerfil();
					nome = usuarioSessao;
					boasVindas = "Olá " + nome + "!";
					alerta = "";
					logado = true;
					link = "/pages/home";
				} else {
					boasVindas = "Bem vindo!";
					alerta = "Senha inválida!";
					logado = false;
				}
			}
		} else {
			link = "/pages/home";
		}
		
		
		ModelAndView modelAndView = new ModelAndView(link); //JSP que ir� acessar
		verificarSessao(modelAndView);
		enviaMsg(modelAndView);
		return modelAndView; //retorna a variavel
	}
	
	
		
	
	@RequestMapping(value = "/adm/vendas", method = RequestMethod.GET) // Pagina de Vendas
	public ModelAndView vendas(@RequestParam(value = "nome", required = false, defaultValue = "Henrique Brand�o") String nome) { //Fun��o e alguns valores que recebe...
		String link = verificaLink("/pages/vendas");
		ModelAndView modelAndView = new ModelAndView(link); //JSP que ir� acessar
		
		List<Categoria> categorias = categoriaDao.buscarAtivos();
		List<Produto> produtos = produtoDao.comEstoque();
		
		modelAndView.addObject("usuarioSessao", usuarioSessao);
		modelAndView.addObject("categorias", categorias);
		modelAndView.addObject("produtos", produtos);
		verificarSessao(modelAndView);
		enviaMsg(modelAndView);
		return modelAndView; //retorna a variavel
	}
	
	@RequestMapping(value = "/adm/todasVendas", method = {RequestMethod.GET, RequestMethod.POST}) // Pagina de Vendas
	public ModelAndView todasVendas(String nota, String pesquisarVendaID) { //Fun��o e alguns valores que recebe...
		String link = verificaLink("/pages/todasVendas");
		ModelAndView modelAndView = new ModelAndView(link); //JSP que ir� acessar
		
		List<Venda> vendas = new ArrayList<Venda>();
		if(nota == null) {
			vendas = vendaDao.ultimas();
		} else {
			vendas = vendaDao.nota(nota);
		}
			List<Venda> vendaAnterior = vendas;
			List<Venda> vendaFinal = new ArrayList<Venda>();
			int ini = 0;
			for(Venda v : vendas) {
				if(ini > 0 ) {
					if(v.getPedido() != vendaAnterior.get(ini-1).getPedido()) {
						vendaFinal.add(v);
					}
				} else {
					vendaFinal.add(v);
				}
				ini++;
			}
			vendas.clear();
			vendas = vendaFinal;
		
		
		if(pesquisarVendaID != null) {
			List<Venda> vendaSelecionada = vendaDao.porPedido(pesquisarVendaID);
			modelAndView.addObject("vendaSelecionada", vendaSelecionada);
		}
		
		modelAndView.addObject("usuarioSessao", usuarioSessao);
		modelAndView.addObject("vendas", vendas);
		verificarSessao(modelAndView);
		enviaMsg(modelAndView);
		return modelAndView; //retorna a variavel
	}
	
	
	@RequestMapping(value = "/adm/funcionarios", method = RequestMethod.GET) // Pagina de Funcion�rios
	public ModelAndView funcionarios(@RequestParam(value = "nome", required = false, defaultValue = "Henrique Brand�o") String nome) { //Fun��o e alguns valores que recebe...
		String link = verificaLink("/pages/funcionarios"); //Session
		ModelAndView modelAndView = new ModelAndView(link); //JSP que ir� acessar.
		
		List<Usuario> usuarios = usuarioDao.funcionariosAtivos();
		
		modelAndView.addObject("usuarios", usuarios);
		verificarSessao(modelAndView); // Verifica a sess�o e a msg de Bem-Vindo
		enviaMsg(modelAndView);
		return modelAndView; //Retorna para a p�gina
	}
	
	
	
	@RequestMapping(value = "/adm/clientes", method = RequestMethod.GET) // Pagina de Clientes
	public ModelAndView clientes(@RequestParam(value = "nome", required = false, defaultValue = "Henrique Brand�o") String nome) { //Fun��o e alguns valores que recebe...
		String link = verificaLink("/pages/clientes"); //Session
		ModelAndView modelAndView = new ModelAndView(link); //JSP que ir� acessar.
		
		List<Usuario> usuarios = usuarioDao.clientesAtivos();
		modelAndView.addObject("usuarios", usuarios);
		
		verificarSessao(modelAndView); // Verifica a sess�o e a msg de Bem-Vindo
		enviaMsg(modelAndView);
		return modelAndView; //Retorna para a p�gina
	}
	
	
	
	@RequestMapping(value = "/adm/produtos", method = RequestMethod.GET) // Pagina de Produtos
	public ModelAndView produtos(@RequestParam(value = "nome", required = false, defaultValue = "Henrique Brand�o") String nome) { //Fun��o e alguns valores que recebe...
		String link = verificaLink("/pages/produtos"); //Link do JSP
		ModelAndView modelAndView = new ModelAndView(link); //JSP que ir� acessar atrav�s do link selecionado.
		
		List<Produto> produtos = produtoDao.buscarAtivos();
		List<Categoria> categorias = categoriaDao.buscarAtivos();
		modelAndView.addObject("categorias", categorias); //Variavel produtos enviada ao JSP.
		modelAndView.addObject("produtos", produtos); //Variavel produtos enviada ao JSP.
		verificarSessao(modelAndView); // Verifica a sess�o.
		enviaMsg(modelAndView); //** Obrigat�rio: para enviar alertas.
		return modelAndView; //Retorna para a p�gina.
	}
	
	@RequestMapping(value = "/adm/categorias", method = RequestMethod.GET) // Pagina de Produtos
	public ModelAndView categorias(@RequestParam(value = "nome", required = false, defaultValue = "Henrique Brand�o") String nome) { //Fun��o e alguns valores que recebe...
		String link = verificaLink("/pages/categorias"); //Link do JSP
		ModelAndView modelAndView = new ModelAndView(link); //JSP que ir� acessar atrav�s do link selecionado.
		
		List<Categoria> categorias = categoriaDao.buscarAtivos();
		modelAndView.addObject("categorias", categorias); //Variavel produtos enviada ao JSP.
		verificarSessao(modelAndView); // Verifica a sess�o.
		enviaMsg(modelAndView); //** Obrigat�rio: para enviar alertas.
		return modelAndView; //Retorna para a p�gina.
	}
	
	
	@RequestMapping(value = "/adm/perfil", method = RequestMethod.GET) // Pagina de Altera��o de Perfil
	public ModelAndView perfil(@RequestParam(value = "nome", required = false, defaultValue = "Henrique Brand�o") String nome) { //Fun��o e alguns valores que recebe...
		String link = verificaLink("/pages/perfil"); //Session
		ModelAndView modelAndView = new ModelAndView(link); //JSP que ir� acessar.
		List<Perfil> perfis = perfilDao.ativos();
		
		verificarSessao(modelAndView); // Verifica a sess�o e a msg de Bem-Vindo
		enviaMsg(modelAndView);
		modelAndView.addObject("perfis", perfis);
		return modelAndView; //Retorna para a p�gina
	}
	
	
	
	
	@RequestMapping(value = "/adm/deletando/{tabela}/{id}", method = {RequestMethod.GET, RequestMethod.POST}) // Pagina de Altera��o de Perfil
	public ModelAndView deletando(@PathVariable("tabela") String tabela, @PathVariable("id") String id) { //Fun��o e alguns valores que recebe...
		//Deletando ID de alguma tabela que recebo.
		Perfil perfildaSessao = perfilDao.findById(Integer.parseInt(""+perfilSessao.getPerfilID())).get();
		String link = verificaLink("/pages/"+tabela); //Session
		ModelAndView modelAndView = new ModelAndView(link); //JSP que ir� acessar.
		
		if(perfildaSessao.getAdmin()) {
			switch (tabela) {  
		       case "perfil" :   
		    	   Perfil perfil = perfilDao.findById(Integer.parseInt(id)).get();
		    	   perfil.setAtivo(false);
		    	   perfilDao.save(perfil);
		    	   atualizarPagina = "/adm/perfil";
		    	   registraMsg("Perfil", "Deletado com sucesso.", "erro");
		       break;   
		       case "funcionario" :   
		    	   Usuario usuario = usuarioDao.findById(Integer.parseInt(id)).get();
		    	   usuario.setAtivo(false);
		    	   usuarioDao.save(usuario);
		    	   registraMsg("Usuário", "Deletado com sucesso.", "erro");
		    	   link = verificaLink("/pages/funcionarios"); //Como tem uma tabela que trata cliente e funcionario devo explicar onde direcionar
		    	   modelAndView = new ModelAndView(link);
		    	   atualizarPagina = "/adm/funcionarios";
		       break;  
		       case "cliente" :   
		    	   Usuario usuarioFunc = usuarioDao.findById(Integer.parseInt(id)).get();
		    	   usuarioFunc.setAtivo(false);
		    	   usuarioDao.save(usuarioFunc);
		    	   registraMsg("Usuário", "Deletado com sucesso.", "erro");
		    	   link = verificaLink("/pages/clientes"); //Como tem uma tabela que trata cliente e funcionario devo explicar onde direcionar
		    	   modelAndView = new ModelAndView(link);
		    	   atualizarPagina = "/adm/clientes";
		       break;
		       case "produto" :   
		    	   Produto produto = produtoDao.findById(Integer.parseInt(id)).get();
		    	   produto.setAtivo(false);
		    	   produtoDao.save(produto);
		    	   registraMsg("Produto", "Deletado com sucesso.", "erro");
		    	   link = verificaLink("/pages/produtos"); //Como tem uma tabela que trata cliente e funcionario devo explicar onde direcionar
		    	   modelAndView = new ModelAndView(link);
		    	   atualizarPagina = "/adm/produtos";
		       break;
		       case "categoria" :   
		    	   Categoria categoria = categoriaDao.findById(Integer.parseInt(id)).get();
		    	   categoria.setAtivo(false);
		    	   categoriaDao.save(categoria);
		    	   registraMsg("Categoria", "Deletado com sucesso.", "erro");
		    	   link = verificaLink("/pages/categorias"); //Como tem uma tabela que trata cliente e funcionario devo explicar onde direcionar
		    	   modelAndView = new ModelAndView(link);
		    	   atualizarPagina = "/adm/categorias";
		       break;
		       case "venda" :   
		    	   List<Venda> vendas = vendaDao.nota(id);
		    	   for(Venda v : vendas) {
		    		   v.setAtivo(false);
			    	   vendaDao.save(v);
		    	   }
		    	   registraMsg("Venda", "Deletada com sucesso.", "erro");
		    	   link = verificaLink("/pages/todasVendas"); //Como tem uma tabela que trata cliente e funcionario devo explicar onde direcionar
		    	   modelAndView = new ModelAndView(link);
		    	   atualizarPagina = "/adm/todasVendas";
		       break;
		     }	
		}
 	   	modelAndView.addObject("atualizarPagina", atualizarPagina);
		return modelAndView; //Retorna para a p�gina
	}
	
	
	/* PESQUISAR PRODUTO - OK*/
	@RequestMapping(value = "/adm/pesquisarProduto", method = {RequestMethod.POST, RequestMethod.GET}) // Pagina de Altera��o de Perfil
	public ModelAndView produto(Produto produto, String produto_categoria, String alterarSalvar) { //Fun��o e alguns valores que recebe...
		String link = verificaLink("/pages/produtos"); //Session
		ModelAndView modelAndView = new ModelAndView(link); //JSP que ir� acessar.
		String filtro="";
		if(produto_categoria != null && !(produto_categoria.equals(""))) {
			filtro = filtro + " and categoria.categoriaID = "+produto_categoria+" ";
		}
		if(produto.getCodigo() != null && !(produto.getCodigo().equals(""))) {
			filtro = filtro + " and codigo like '%"+produto.getCodigo()+"%' ";
		}
		if(produto.getDescricao() != null && !(produto.getDescricao().equals(""))) {
			filtro = filtro + " and descricao like '%"+produto.getDescricao()+"%' ";
		}
		if(produto.getEan() != null && !(produto.getEan().equals(""))) {
			filtro = filtro + " and ean like '%"+produto.getEan()+"%' ";
		}
		if(produto.getEstoque() != null && !(produto.getEstoque().toString().equals(""))) {
			filtro = filtro + " and estoque = '"+produto.getEstoque()+"' ";
		}
		if(produto.getFornecedor() != null && !(produto.getFornecedor().equals(""))) {
			filtro = filtro + " and fornecedor like '%"+produto.getFornecedor()+"%' ";
		}
		if(produto.getMarca() != null && !(produto.getMarca().equals(""))) {
			filtro = filtro + " and marca like '%"+produto.getMarca()+"%' ";
		}
		if(produto.getPeso() != null && !(produto.getPeso().toString().equals(""))) {
			filtro = filtro + " and peso = '"+produto.getPeso()+"' ";
		}
		if(produto.getPreco() != null && !(produto.getPreco().toString().equals(""))) {
			filtro = filtro + " and preco = '"+produto.getPreco()+"' ";
		}
		if(produto.getPrecoPromocional() != null && !(produto.getPrecoPromocional().toString().equals(""))) {
			filtro = filtro + " and precoPromocional like '"+produto.getPrecoPromocional()+"' ";
		}
		if(produto.getTipoPeso() != null && !(produto.getTipoPeso().equals(""))) {
			filtro = filtro + " and tipoPeso like '"+produto.getTipoPeso()+"' ";
		}
		if(produto.getUnidades() != null && !(produto.getUnidades().toString().equals(""))) {
			filtro = filtro + " and unidades = '"+produto.getUnidades()+"' ";
		}
		if(produto.getImgPath() != null && !(produto.getImgPath().equals(""))) {
			filtro = filtro + " and imgPath like '%"+produto.getImgPath()+"%' ";
		}

		List<Categoria> categorias = categoriaDao.buscarAtivos();
		List<Produto> produtos = produtoDao.filtro(filtro);
		if(produtos.size() <= 0) {
			produtos = produtoDao.findAll();
			registraMsg("Perfil", "Registro não encontrado.", "erro");
		}
		
		atualizarPagina = "/adm/produtos";
		verificarSessao(modelAndView); // Verifica a sess�o e a msg de Bem-Vindo
		enviaMsg(modelAndView);
		modelAndView.addObject("categorias", categorias);
		modelAndView.addObject("produtos", produtos);
		return modelAndView; //Retorna para a p�gina
	}
	/* PESQUISAR PRODUTO - OK*/
	
	
	/* PESQUISAR FUNCION�RIO - OK*/
	@RequestMapping(value = "/adm/pesquisarUsuario", method = {RequestMethod.POST, RequestMethod.GET}) // Pagina de Altera��o de Perfil
	public ModelAndView funcionario(Usuario usuario, String permissaoFunc) { //Fun��o e alguns valores que recebe...
		String link = verificaLink("/pages/funcionarios"); //Session
		ModelAndView modelAndView = new ModelAndView(link); //JSP que ir� acessar.
		String filtro="";
		if(usuario.getCodigo() != null && !(usuario.getCodigo().equals(""))) {
			filtro = filtro + " and codigo like '%"+usuario.getCodigo()+"%' ";
		}
		if(usuario.getEmail() != null && !(usuario.getEmail().equals(""))) {
			filtro = filtro + " and email like '%"+usuario.getEmail()+"%' ";
		}
		if(usuario.getLogin() != null && !(usuario.getLogin().equals(""))) {
			filtro = filtro + " and login like '%"+usuario.getLogin()+"%' ";
		}
		if(usuario.getNome() != null && !(usuario.getNome().equals(""))) {
			filtro = filtro + " and nome like '%"+usuario.getNome()+"%' ";
		}
		if(permissaoFunc.equals("admin")) {
			filtro = filtro + " and perfil.admin = 1 ";
			link = verificaLink("/pages/funcionarios"); //Session
			modelAndView = new ModelAndView(link); //JSP que ir� acessar.
		}
		if(permissaoFunc.equals("funcionario")) {
			filtro = filtro + " and perfil.funcionario = 1 ";
			link = verificaLink("/pages/funcionarios"); //Session
			modelAndView = new ModelAndView(link); //JSP que ir� acessar.
		}
		if(permissaoFunc.equals("cliente")) {
			filtro = filtro + " and perfil.cliente = 1 ";
			link = verificaLink("/pages/clientes"); //Session
			modelAndView = new ModelAndView(link); //JSP que ir� acessar.
		}
		if(permissaoFunc.equals("visitante")) {
			filtro = filtro + " and perfil.visitante = 1 ";
			link = verificaLink("/pages/clientes"); //Session
			modelAndView = new ModelAndView(link); //JSP que ir� acessar.
		}
		List<Usuario> usuarios = usuarioDao.filtro(filtro);
		if(usuarios.size() <= 0) {
			usuarios = usuarioDao.findAll();
			registraMsg("Perfil", "Registro não encontrado.", "erro");
		}
		
		atualizarPagina = "/adm/usuarios";
		verificarSessao(modelAndView); // Verifica a sess�o e a msg de Bem-Vindo
		enviaMsg(modelAndView);
		modelAndView.addObject("usuarios", usuarios);
		return modelAndView; //Retorna para a p�gina
	}
	/* PESQUISAR FUNCION�RIO - OK*/
	
	

	/* PESQUISAR PERFIL - OK*/
	@RequestMapping(value = "/adm/pesquisarPerfil", method = {RequestMethod.POST, RequestMethod.GET}) // Pagina de Altera��o de Perfil
	public ModelAndView perfil(Perfil perfil, String permissao) { //Fun��o e alguns valores que recebe...
		String link = verificaLink("/pages/perfil"); //Session
		ModelAndView modelAndView = new ModelAndView(link); //JSP que ir� acessar.
		String filtro="";
		if(perfil.getDescricao() != null && !(perfil.getDescricao().equals(""))) {
			filtro = filtro + " and descricao like '%"+perfil.getDescricao()+"%' ";
		}
		if(perfil.getCodigo() != null && !(perfil.getCodigo().equals(""))) {
			filtro = filtro + " and codigo like '"+perfil.getCodigo()+"' ";
		}
		if(permissao.equals("admin")) {
			filtro = filtro + " and admin = 1 ";
		}
		if(permissao.equals("funcionario")) {
			filtro = filtro + " and funcionario = 1 ";
		}
		if(permissao.equals("cliente")) {
			filtro = filtro + " and cliente = 1 ";
		}
		if(permissao.equals("visitante")) {
			filtro = filtro + " and visitante = 1 ";
		}
		List<Perfil> perfis = perfilDao.filtro(filtro);
		if(perfis.size() <= 0) {
			perfis = perfilDao.findAll();
			registraMsg("Perfil", "Registro não encontrado.", "erro");
		}
		
		atualizarPagina = "/adm/perfil";
		verificarSessao(modelAndView); // Verifica a sess�o e a msg de Bem-Vindo
		enviaMsg(modelAndView);
		modelAndView.addObject("perfis", perfis);
		return modelAndView; //Retorna para a p�gina
	}
	/* PESQUISAR PERFIL - OK*/

	
	/* ATUALIZAR PERFIL - OK*/
	@RequestMapping(value = "/adm/atualizarPerfil", method = {RequestMethod.POST, RequestMethod.GET}) // Pagina de Altera��o de Perfil
	public ModelAndView atualizarPerfil(Perfil perfil, String permissao) { //Fun��o e alguns valores que recebe...
		//Deletando ID de alguma tabela que recebo.
		Perfil perfildaSessao = perfilDao.findById(Integer.parseInt(""+perfilSessao.getPerfilID())).get();
		System.out.println("Perfil da Sessão: "+ perfildaSessao );
		
		String link = verificaLink("/pages/perfil"); //Session
		ModelAndView modelAndView = new ModelAndView(link); //JSP que ir� acessar.
		
		if(perfildaSessao.getAdmin()) {
			Perfil novoPerfil = new Perfil();
			if(perfil.getPerfilID() != null) {
				novoPerfil = perfilDao.findById(Integer.parseInt(""+perfil.getPerfilID())).get();
			}
	    	novoPerfil.setAtivo(true);
	    	novoPerfil.setDescricao(perfil.getDescricao());
	    	novoPerfil.setCodigo(perfil.getCodigo());
	    	if(permissao.equals("admin")) {
	    		novoPerfil.setAdmin(true);
	    		novoPerfil.setCliente(false);
	    		novoPerfil.setFuncionario(false);
	    		novoPerfil.setVisitante(false);
	    	} else if(permissao.equals("cliente")) {
	    		novoPerfil.setCliente(true);
	    		novoPerfil.setAdmin(false);
	    		novoPerfil.setFuncionario(false);
	    		novoPerfil.setVisitante(false);
	    	} else if(permissao.equals("funcionario")) {
	    		novoPerfil.setFuncionario(true);
	    		novoPerfil.setAdmin(false);
	    		novoPerfil.setCliente(false);
	    		novoPerfil.setVisitante(false);
	    	} else if(permissao.equals("visitante")) {
	    		novoPerfil.setVisitante(true);
	    		novoPerfil.setAdmin(false);
	    		novoPerfil.setCliente(false);
	    		novoPerfil.setFuncionario(false);
	    	} else {
	    		novoPerfil.setCliente(true);
	    		novoPerfil.setAdmin(false);
	    		novoPerfil.setFuncionario(false);
	    		novoPerfil.setVisitante(false);
	    	}
	    	perfilDao.save(novoPerfil);
	    	atualizarPagina = "/adm/perfil";
	    	registraMsg("Perfil", "Salvo com sucesso.", "info");
		}	
 	   	modelAndView.addObject("atualizarPagina", atualizarPagina);
		return modelAndView; //Retorna para a p�gina
	}

	/* ATUALIZAR USU�RIO */
	@RequestMapping(value = "/adm/atualizarUsuario", method = {RequestMethod.POST, RequestMethod.GET}) // Pagina de Altera��o de Perfil
	public ModelAndView atualizarUsuario(Usuario usuario, String permissaoFunc, String codigoFunc, String senhaRepetida, String alterarSalvar, String funcCliente) { //Fun��o e alguns valores que recebe...
		//Deletando ID de alguma tabela que recebo.
		Perfil perfildaSessao = perfilDao.findById(Integer.parseInt(""+perfilSessao.getPerfilID())).get();
		System.out.println("perfildaSessao " +perfildaSessao.getDescricao());
		String link = verificaLink("/pages/funcionarios"); //Session
		Boolean valido = false;
		Boolean funcionario;
		if(permissaoFunc.equals("funcionario") || permissaoFunc.equals("admin")) {
			funcionario = true;
			link = verificaLink("/pages/funcionarios"); //Session
		}else {
			funcionario = false;
			link = verificaLink("/pages/clientes"); //Session
		}
		ModelAndView modelAndView = new ModelAndView(link); //JSP que ir� acessar.
		List<Usuario> usuariosInvalidos = usuarioDao.usuarioInvalido(codigoFunc, usuario.getEmail(), usuario.getLogin());
		if(alterarSalvar.equals("novo")) {
			if(usuariosInvalidos.size() > 0) {
				valido = false;
			} else {
				valido = true;
			}
		} else {
			valido = true;
		}
		
		if(valido) {
			if(senhaRepetida.equals(usuario.getSenha())) {
				if(perfildaSessao.getAdmin()) {
					System.out.println("V3" +perfildaSessao);
					Usuario novoUsuario = new Usuario();
					if(usuario.getID() != null) {
						novoUsuario = usuarioDao.findById(usuario.getID()).get();
					}
					novoUsuario.setAtivo(true);
			    	novoUsuario.setCodigo(codigoFunc);
			    	novoUsuario.setEmail(usuario.getEmail());
			    	novoUsuario.setLogin(usuario.getLogin());
			    	novoUsuario.setNome(usuario.getNome());
			    	if(alterarSalvar.equals("novo")) {
			    		novoUsuario.setSenha(usuario.getSenha());
			    	}
			    	List <Perfil> perfis = perfilDao.findAll();
			    	if(permissaoFunc.equals("admin")) {
			    		for(int i = 0; i < perfis.size() ; i++) {
			    			if(perfis.get(i).getAdmin()) {
			    				novoUsuario.setPerfil(perfis.get(i));
			    				break;
			    			}
			    		}
			    	} else if(permissaoFunc.equals("cliente")) {
			    		for(int i = 0; i < perfis.size() ; i++) {
			    			if(perfis.get(i).getCliente()) {
			    				novoUsuario.setPerfil(perfis.get(i));
			    				break;
			    			}
			    		}
			    	} else if(permissaoFunc.equals("funcionario")) {
			    		for(int i = 0; i < perfis.size() ; i++) {
			    			if(perfis.get(i).getFuncionario()) {
			    				novoUsuario.setPerfil(perfis.get(i));
			    				break;
			    			}
			    		}
			    	} else if(permissaoFunc.equals("visitante")) {
			    		for(int i = 0; i < perfis.size() ; i++) {
			    			if(perfis.get(i).getVisitante()) {
			    				novoUsuario.setPerfil(perfis.get(i));
			    				break;
			    			}
			    		}
			    	}
			    	usuarioDao.save(novoUsuario);
			    	if(funcionario) {
			    		atualizarPagina = "/adm/funcionarios";
				    	registraMsg("Funcionário", "Salvo com sucesso.", "info");
			    	} else {
			    		atualizarPagina = "/adm/clientes";
				    	registraMsg("Cliente", "Salvo com sucesso.", "info");
			    	}
				}
			} else {
				if(funcionario) {
					atualizarPagina = "/adm/funcionarios";
					registraMsg("Funcionário", "A senha não confere com a senha repetida", "erro");
				} else {
					atualizarPagina = "/adm/clientes";
					registraMsg("Cliente", "A senha não confere com a senha repetida", "erro");
				}
				
			}
		} else {
			if(funcionario) {
				atualizarPagina = "/adm/funcionarios";
				registraMsg("Funcionário", "Já constam registros deste usuário no sistema.", "erro");
			} else {
				atualizarPagina = "/adm/clientes";
				registraMsg("Cliente", "Já constam registros deste usuário no sistema.", "erro");
			}
		}
 	   	modelAndView.addObject("atualizarPagina", atualizarPagina);
		return modelAndView; //Retorna para a p�gina
	}
	
	
	
	/* ATUALIZAR PRODUTO - OK*/
	@RequestMapping(value = "/adm/atualizarProduto", method = {RequestMethod.POST, RequestMethod.GET}) // Pagina de Altera��o de Perfil
	public ModelAndView atualizarProduto(Produto produto, String alterarSalvar, String produto_categoria) { //Fun��o e alguns valores que recebe...
		//Deletando ID de alguma tabela que recebo.
		
		Perfil perfildaSessao = perfilDao.findById(Integer.parseInt(""+perfilSessao.getPerfilID())).get();
		String link = verificaLink("/pages/perfil"); //Session
		ModelAndView modelAndView = new ModelAndView(link); //JSP que ir� acessar.
		
		Boolean repetido = false;
		Produto produtoRepetido = produtoDao.porCodigo(produto.getCodigo());
		Categoria categoriaProduto = categoriaDao.findById(Integer.parseInt(produto_categoria)).get();
		
		if(perfildaSessao.getAdmin()) {
			Produto p = new Produto();
			if(produto.getProdutoID() != null) {
				p = produtoDao.findById(Integer.parseInt(""+produto.getProdutoID())).get();
			}
			if((produtoRepetido != null && alterarSalvar.equals("edita")) || (produtoRepetido == null && alterarSalvar.equals("novo"))) {
	    	p.setAtivo(true);
	    	p.setCodigo(produto.getCodigo());
	    	p.setDescricao(produto.getDescricao());
	    	p.setEan(produto.getEan());
	    	p.setEstoque(produto.getEstoque());
	    	p.setFornecedor(produto.getFornecedor());
	    	p.setMarca(produto.getMarca());
	    	p.setPeso(produto.getPeso());
	    	p.setPreco(produto.getPreco());
	    	p.setPrecoPromocional(produto.getPrecoPromocional());
	    	p.setTipoPeso(produto.getTipoPeso());
	    	p.setUnidades(produto.getUnidades());
	    	p.setImgPath(produto.getImgPath());
	    	p.setCategoria(categoriaProduto);
	    	produtoDao.save(p);
	    	atualizarPagina = "/adm/produtos";
	    	registraMsg("Produto", "Salvo com sucesso.", "info");
			} else {
				atualizarPagina = "/adm/produtos";
		    	registraMsg("Produto", "Já consta um produto com este código.", "erro");
			}
	    	
		}	
 	   	modelAndView.addObject("atualizarPagina", atualizarPagina);
		return modelAndView; //Retorna para a p�gina
	}
	
		
	
	/* ATUALIZAR CATEGORIA - OK*/
	@RequestMapping(value = "/adm/atualizarCategoria", method = {RequestMethod.POST, RequestMethod.GET}) // Pagina de Altera��o de Perfil
	public ModelAndView atualizarCategoria(Categoria categoria, String alterarSalvar, String permissao) { //Fun��o e alguns valores que recebe...
		//Deletando ID de alguma tabela que recebo.
		Perfil perfildaSessao = perfilDao.findById(Integer.parseInt(""+perfilSessao.getPerfilID())).get();
		String link = verificaLink("/pages/categorias"); //Session
		ModelAndView modelAndView = new ModelAndView(link); //JSP que ir� acessar.
		Boolean vazio = true;
		if(perfildaSessao.getAdmin()) {
			Categoria novaCategoria = new Categoria();
			if(categoria.getCodigo() != null) {
				novaCategoria = categoriaDao.porCodigo(categoria.getCodigo());
			}
			if(novaCategoria != null) {
				if(novaCategoria.getCodigo() != null) {
					vazio = false;
				}
			} else {
				novaCategoria = new Categoria();
			}
			if((alterarSalvar.equals("novo") && vazio) || alterarSalvar.equals("edita") && !vazio) {
		    	novaCategoria.setDescricao(categoria.getDescricao());
		    	novaCategoria.setCodigo(categoria.getCodigo());
		    	novaCategoria.setAtivo(true);
		    	categoriaDao.save(novaCategoria);
		    	atualizarPagina = "/adm/categorias";
		    	registraMsg("Categoria", "Salvo com sucesso.", "info");
			} else {
				atualizarPagina = "/adm/categorias";
				registraMsg("Categoria", "Já constam registros desta categoria no sistema.", "erro");
			}
		}	
 	   	modelAndView.addObject("atualizarPagina", atualizarPagina);
		return modelAndView; //Retorna para a p�gina
	}
	/* ATUALIZAR CATEGORIA*/
	
	
	/* PESQUISAR CATEGORIA - OK*/
	@RequestMapping(value = "/adm/pesquisarCategoria", method = {RequestMethod.POST, RequestMethod.GET}) // Pagina de Altera��o de Perfil
	public ModelAndView categoria(Categoria categoria, String permissao) { //Fun��o e alguns valores que recebe...
		String link = verificaLink("/pages/categorias"); //Session
		ModelAndView modelAndView = new ModelAndView(link); //JSP que ir� acessar.
		String filtro="";
		if(categoria.getDescricao() != null && !(categoria.getDescricao().equals(""))) {
			filtro = filtro + " and descricao like '%"+categoria.getDescricao()+"%' ";
		}
		if(categoria.getCodigo() != null && !(categoria.getCodigo().equals(""))) {
			filtro = filtro + " and codigo like '"+categoria.getCodigo()+"' ";
		}
		List<Categoria> categorias = categoriaDao.filtro(filtro);
		if(categorias.size() <= 0) {
			categorias = categoriaDao.findAll();
			registraMsg("Categoria", "Registro não encontrado.", "erro");
		}
		atualizarPagina = "/adm/categorias";
		verificarSessao(modelAndView); // Verifica a sess�o e a msg de Bem-Vindo
		enviaMsg(modelAndView);
		modelAndView.addObject("categorias", categorias);
		return modelAndView; //Retorna para a p�gina
	}
	/* PESQUISAR CATEGORIA - OK*/
	
	
	/* SALVAR VENDA */
	@RequestMapping(value = "/adm/finalizarVenda", method = {RequestMethod.POST, RequestMethod.GET}) // Pagina de Altera��o de Perfil
	public ModelAndView finalizaVenda(String pedidoVenda, String notaDataVenda, String valorTotalVenda, String vendas) { //Fun��o e alguns valores que recebe...
		Perfil perfildaSessao = perfilDao.findById(Integer.parseInt(""+perfilSessao.getPerfilID())).get();
		String link = verificaLink("/pages/vendas"); //Session
		ModelAndView modelAndView = new ModelAndView(link); //JSP que ir� acessar.
		
		List<Produto> produtos = new ArrayList<Produto>();
		try {
			JSONObject obj = new JSONObject(vendas);
			JSONArray arr = obj.getJSONArray("Produtos");
	        for (int i = 0; i < arr.length(); i++) {
	        	String codigo = arr.getJSONObject(i).getString("codigo");
	        	String qtd = arr.getJSONObject(i).getString("qtd");
	        	Produto pr = produtoDao.porCodigo(codigo);
	        	if(pr.getCodigo() != null) {
	        		Venda venda = new Venda();
	        		venda.setPedido(pedidoVenda);
	        		venda.setTotal(Double.parseDouble(valorTotalVenda));
	        		pr.setEstoque(pr.getEstoque() - Integer.parseInt(qtd));
	        		venda.setProdutos(pr);
	        		venda.setPrecoUnit((pr.getPreco() - pr.getPrecoPromocional()));
	        		venda.setQuantidade(Integer.parseInt(qtd));
	        		venda.setSubtotal(Integer.parseInt(qtd) * (venda.getPrecoUnit()));
	        		if(pr.getPrecoPromocional() > 0) {
	        			venda.setPromocao(true);
	        		}
	        		venda.setFuncionario(usuarioIdSessao);
	        		vendaDao.save(venda);
	        		produtoDao.save(pr);
	        	}
	        }
		}catch(Exception e) {
			registraMsg("Erro na Venda", "Ocorreu um erro: " + e , "erro");
		}
		
		registraMsg("Venda", "Venda finalizada com sucesso.", "info");
		atualizarPagina = "/adm/vendas";
		modelAndView.addObject("atualizarPagina", atualizarPagina);
		return modelAndView; //Retorna para a p�gina
	}
	
	
	
	/* SALVAR EXCEL */
	@Transactional
	@RequestMapping(value = "/adm/upload/excel", method = {RequestMethod.POST, RequestMethod.GET}) // Pagina de Altera��o de Perfil
	public ModelAndView uploadExcel(String tabelaUsada, @ModelAttribute MultipartFile file) throws Exception, IOException { //Fun��o e alguns valores que recebe...
		Perfil perfildaSessao = perfilDao.findById(Integer.parseInt(""+perfilSessao.getPerfilID())).get();
		String link = verificaLink("/pages/vendas"); //Session
		switch (tabelaUsada) {  
	       case "produtos" :
	    	   processaProduto(file);
	    	   link = verificaLink("/pages/produtos");
	    	   atualizarPagina = "/adm/produtos";
	    	   break;
	       case "perfis" :
	    	   processaPerfil(file);
	    	   link = verificaLink("/pages/perfil");
	    	   atualizarPagina = "/adm/perfil";
	    	   break;
	       case "categorias" :
	    	   processaCategoria(file);
	    	   link = verificaLink("/pages/categorias");
	    	   atualizarPagina = "/adm/categorias";
	    	   break;
	       case "clientes" :
	    	   processaUsuario(file);
	    	   link = verificaLink("/pages/clientes");
	    	   atualizarPagina = "/adm/clientes";
	    	   break;
	       case "funcionarios" :
	    	   processaUsuario(file);
	    	   link = verificaLink("/pages/funcionarios");
	    	   atualizarPagina = "/adm/funcionarios";
	    	   break;
		}
		
		ModelAndView modelAndView = new ModelAndView(link); //JSP que ir� acessar.
		registraMsg("Excel", "Dados inseridos com sucesso..", "info");
		modelAndView.addObject("atualizarPagina", atualizarPagina);
		return modelAndView; //Retorna para a p�gina
	}
	
	
	
public List<Tabela> uploadExcelFile(@ModelAttribute MultipartFile file) throws Exception {
		
		List<Tabela> tabelas = new ArrayList<Tabela>();
		int linha = 1;
		int coluna = 0;
		try {
			InputStream in = file.getInputStream();
		    XSSFWorkbook workbook = new XSSFWorkbook(in);
		    XSSFSheet sheet = workbook.getSheet("Sheet1");
		    if(sheet == null) {
				sheet = workbook.getSheet("Plan1");
			}
		    if(sheet == null) {
				sheet = workbook.getSheet("Planilha1");
			}
			Iterator<Row> rowIterator = sheet.rowIterator();
			while (rowIterator.hasNext()) {
				coluna = 0;
				Row row = rowIterator.next();
				if (row.getRowNum() == 0) {
					continue;
				}
				Iterator<Cell> cellIterator = row.cellIterator();
				while (cellIterator.hasNext()) {
					Cell cell = cellIterator.next();
						if (cell.getCellType() == Cell.CELL_TYPE_STRING) {
							Tabela tabela = new Tabela();
							tabela.setLinha(linha);
							tabela.setConteudo(cell.getStringCellValue());
							tabela.setColuna(coluna);
							tabelas.add(tabela);
						}
						else if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							Tabela tabela = new Tabela();
							tabela.setLinha(linha);
							tabela.setConteudo(cell.getNumericCellValue() + "");
							tabela.setColuna(coluna);
							tabelas.add(tabela);
						}
					coluna++;
				}
				linha++;
			}
		    in.close();
		    workbook.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
		return tabelas;
	}
	
	
	public void processaPerfil(@ModelAttribute MultipartFile file) throws Exception {
		int coluna = 0;
		int finalLinha = 0;
		String conteudo = "";
		Perfil p = new Perfil();
		
		List<Tabela> tabela = uploadExcelFile(file);
		try {
		for(int i=0; i < tabela.size(); i++) {
			coluna = tabela.get(i).getColuna();
			conteudo = tabela.get(i).getConteudo();
			// ::: Aqui varia de tabela pra tabela pra popular os campos :::
			if(coluna == 0) p.setCodigo(conteudo);
			if(coluna == 1) p.setDescricao(conteudo);
			
			if(coluna == 2) {
				conteudo = conteudo.toLowerCase();
				if(conteudo.equals("admin")) {
					p.setAdmin(true);
				}
				if(conteudo.equals("cliente")) {
					p.setCliente(true);
				}
				if(conteudo.equals("funcionario") || conteudo.equals("funcion�rio")) {
					p.setFuncionario(true);
				}
				if(conteudo.equals("visitante")) {
					p.setVisitante(true);
				}
			}
			
			if(finalLinha >= 2) {
				finalLinha = -1;
				perfilDao.save(p);
				p = new Perfil();
			}
			finalLinha++;
		}
		} catch(Exception e) {
			System.out.println("Erro: " + e);
			registraMsg("Upload", "Erro: " + e, "erro");
		}
	}
	
	
	
	public void processaCategoria(@ModelAttribute MultipartFile file) throws Exception {
		int coluna = 0;
		int finalLinha = 0;
		String conteudo = "";
		Categoria ca = new Categoria();
		List<Tabela> tabela = uploadExcelFile(file);
		try {
		for(int i=0; i < tabela.size(); i++) {
			coluna = tabela.get(i).getColuna();
			conteudo = tabela.get(i).getConteudo();
			// ::: Aqui varia de tabela pra tabela pra popular os campos :::
			if(coluna == 0) ca.setCodigo(conteudo);
			if(coluna == 1) ca.setDescricao(conteudo);
			
			if(finalLinha >= 1) {
				finalLinha = -1;
				categoriaDao.save(ca);
				ca = new Categoria();
			}
			finalLinha++;
		}
		} catch(Exception e) {
			registraMsg("Upload", "Erro: " + e, "erro");
		}
	}
	
	
	
	
	public void processaUsuario(@ModelAttribute MultipartFile file) throws Exception {
		int coluna = 0;
		int finalLinha = 0;
		String conteudo = "";
		Usuario u = new Usuario();
		List<Tabela> tabela = uploadExcelFile(file);
		try {
		for(int i=0; i < tabela.size(); i++) {
			coluna = tabela.get(i).getColuna();
			conteudo = tabela.get(i).getConteudo();
			// ::: Aqui varia de tabela pra tabela pra popular os campos :::
			if(coluna == 0) u.setLogin(conteudo);
			if(coluna == 1) u.setNome(conteudo);
			if(coluna == 2) u.setPerfil(perfilDao.porNome(conteudo));
			if(coluna == 3) u.setCodigo(conteudo);
			if(coluna == 4) u.setEmail(conteudo);
			u.setSenha("teste123");
			
			if(finalLinha >= 4) {
				finalLinha = -1;
				usuarioDao.save(u);
				u = new Usuario();
			}
			finalLinha++;
		}
		} catch(Exception e) {
			registraMsg("Upload", "Erro: " + e, "erro");
		}
	}
	
	
	
	public void processaProduto(@ModelAttribute MultipartFile file) throws Exception {
		int coluna = 0;
		int finalLinha = 0;
		String conteudo = "";
		Produto p = new Produto();
		List<Tabela> tabela = uploadExcelFile(file);
		System.out.println("Size: " + tabela.size());
		try {
		for(int i=0; i<tabela.size(); i++) {
			coluna = tabela.get(i).getColuna();
			conteudo = tabela.get(i).getConteudo();
			System.out.println("Coluna: " + coluna + " - Conteudo: " + conteudo);
			// ::: Aqui varia de tabela pra tabela pra popular os campos :::
			if(coluna == 0) p.setCodigo(conteudo);
			if(coluna == 1) p.setEan(conteudo);
			if(coluna == 2) p.setDescricao(conteudo);
			if(coluna == 3) p.setPreco(Double.parseDouble(conteudo));
			if(coluna == 4) p.setCategoria(categoriaDao.porNome(conteudo));
			if(coluna == 5) p.setPrecoPromocional(Double.parseDouble(conteudo));
			if(coluna == 6) p.setEstoque(Integer.parseInt(conteudo.replace(".00", "").replace(".0", "")));
			if(coluna == 7) p.setFornecedor(conteudo);
			if(coluna == 8) p.setMarca(conteudo);
			if(coluna == 9) p.setPeso(Double.parseDouble(conteudo));
			if(coluna == 10) p.setTipoPeso(conteudo);
			if(coluna == 11) p.setUnidades(Integer.parseInt(conteudo));
			if(coluna == 12) p.setImgPath(conteudo);
			
			if(finalLinha >= 12) {
				finalLinha = -1;
				produtoDao.save(p);
				p = new Produto();
			}
			finalLinha++;
		}
		} catch(Exception e) {
			System.out.println("Erro: "+e);
			registraMsg("Upload", "Erro: " + e, "erro");
		}
	}
	
}
