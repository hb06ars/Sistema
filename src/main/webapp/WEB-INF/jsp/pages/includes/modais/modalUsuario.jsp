<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>



<!--  EDITAR FUNCIONARIO -->
<script>
function modalEditarUsuario(id, login, nome, codigo, email, tipo){
	document.getElementById("form").action = "/adm/atualizarUsuario";
	var funcCliente = '';
	var index = 1;
	if(tipo == 'admin'){
		index = 1;
		funcCliente = 'funcionario';
	}else if(tipo == 'cliente'){
		index = 2;
		funcCliente = 'cliente';
	}else if(tipo == 'funcionario'){
		index = 3;
		funcCliente = 'funcionario';
	}else if(tipo == 'visitante'){
		index = 4;
		funcCliente = 'cliente';
	}
	document.getElementById("permissaoFunc").selectedIndex = index;
	document.getElementById("ID").value = id;
	document.getElementById("nome").value = nome;
	document.getElementById("codigoFunc").value = codigo;
	document.getElementById("codigoFunc").readOnly = true;
	document.getElementById("login").value = login;
	document.getElementById("login").readOnly = true;
	document.getElementById("email").value = email;
	document.getElementById("senha").style.display = 'none';
	document.getElementById("senhaRepetida").style.display = 'none';
	document.getElementById("senha").value = '';
	document.getElementById("senhaRepetida").value = '';
	document.getElementById("senhaRepetida").required = false;
	document.getElementById("senha").required = false;
	document.getElementById("labelSenha").style.display = 'none';
	document.getElementById("labelSenhaRepetida").style.display = 'none';
	document.getElementById("alterarSalvar").value = 'editar';
	document.getElementById("funcCliente").value = funcCliente;
	$("#modalEditarFuncionario").modal().show();
}

function modalNovoUsuario(){
	document.getElementById("form").action = "/adm/atualizarUsuario";
	document.getElementById("nome").value = '';
	document.getElementById("nome").required = true;
	document.getElementById("codigoFunc").value = '';
	document.getElementById("codigoFunc").required = true;
	document.getElementById("codigoFunc").readOnly = false;
	document.getElementById("email").readOnly = false;
	document.getElementById("login").value = '';
	document.getElementById("login").required = true;
	document.getElementById("email").value = '';
	document.getElementById("email").required = true;
	document.getElementById("senha").style.display = 'block';
	document.getElementById("senha").required = true;
	document.getElementById("senhaRepetida").style.display = 'block';
	document.getElementById("senhaRepetida").required = true;
	document.getElementById("labelSenha").style.display = 'block';
	document.getElementById("labelSenhaRepetida").style.display = 'block';
	document.getElementById("alterarSalvar").value = 'novo';
	document.getElementById("permissaoFunc").required = true;
	document.getElementById("funcCliente").value = funcCliente;
	$("#modalEditarFuncionario").modal().show();
}


function modalPesquisarUsuario(){
	document.getElementById("form").action = "/adm/pesquisarUsuario";
	document.getElementById("nome").value = '';
	document.getElementById("nome").required = false;
	document.getElementById("codigoFunc").value = '';
	document.getElementById("codigoFunc").readOnly = false;
	document.getElementById("codigoFunc").required = false;
	document.getElementById("login").value = '';
	document.getElementById("login").required = false;
	document.getElementById("email").value = '';
	document.getElementById("email").required = false;
	document.getElementById("senha").style.display = 'none';
	document.getElementById("senha").required = false;
	document.getElementById("senhaRepetida").style.display = 'none';
	document.getElementById("senhaRepetida").required = false;
	document.getElementById("labelSenha").style.display = 'none';
	document.getElementById("labelSenhaRepetida").style.display = 'none';
	document.getElementById("permissaoFunc").required = false;
	document.getElementById("alterarSalvar").value = 'novo';
	document.getElementById("funcCliente").value = funcCliente;
	$("#modalEditarFuncionario").modal().show();
}



</script>


<form action="<c:url value='/adm/atualizarUsuario'/>" id="form" method="post" >
<div class="modal fade" id="modalEditarFuncionario" tabindex="-1" role="dialog" aria-labelledby="TituloModalCentralizado" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="TituloModalCentralizado">Registro</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body input-group mb-3">
      	<div class="input-group mb-3">
  			<div>
  			Nome:
  			</div>
  			<div class="input-group mb-3">
  				<input class="form-control" id="nome" name="nome" type="text" required aria-describedby="inputGroup-sizing-default">
			</div>
		</div>
		<div class="input-group mb-3">
  			<div>
  			Perfil:
  			</div>
  			<div class="input-group mb-3">
  				<select style="height=:100%; width=:100%" class="form-control" id="permissaoFunc" name="permissaoFunc" required aria-describedby="inputGroup-sizing-default">
						<option value="" >-- Selecione --</option>
						<option value="admin" >Admin</option>
						<option value="cliente" >Cliente</option>
						<option value="funcionario" >Funcionário</option>
						<option value="visitante" >Visitante</option>				  	
				</select>
			</div>
		</div>
		<div class="input-group mb-3">
  			<div>
  			Código:
  			</div>
  			<div class="input-group mb-3">
  				<input class="form-control" id="codigoFunc" name="codigoFunc" type="text" required aria-describedby="inputGroup-sizing-default">
			</div>
		</div>
		<div class="input-group mb-3">
  			<div>
  			Login:
  			</div>
  			<div class="input-group mb-3">
  				<input class="form-control" id="login" name="login" type="text" required aria-describedby="inputGroup-sizing-default">
			</div>
		</div>
		<div class="input-group mb-3">
  			<div>
  			Email:
  			</div>
  			<div class="input-group mb-3">
  				<input class="form-control" id="email" name="email" type="text" required aria-describedby="inputGroup-sizing-default">
			</div>
		</div>
		<div class="input-group mb-3" id="labelSenha">
  			<div>
  			Senha:
  			</div>
  			<div class="input-group mb-3">
  				<input class="form-control" id="senha" name="senha" type="password" required aria-describedby="inputGroup-sizing-default">
			</div>
		</div>
		<div class="input-group mb-3" id="labelSenhaRepetida">
  			<div>
  			Repita a Senha:
  			</div>
  			<div class="input-group mb-3">
  				<input class="form-control" id="senhaRepetida" name="senhaRepetida" type="password" required aria-describedby="inputGroup-sizing-default">
			</div>
		</div>
      </div>
      <div class="modal-footer">
      	<input type="hidden" name="funcCliente" id="funcCliente" value="">
		<input type="hidden" name="alterarSalvar" id="alterarSalvar">
      	<input type="hidden" name="ID" id="ID">
      	<input type="submit" name="submit" class="btn btn-primary" value="Ok">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
      </div>
    </div>
  </div>
</div>
</form>
<!--  EDITAR FUNCIONARIO -->


