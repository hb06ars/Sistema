<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>



<!--  EDITAR FUNCIONARIO -->
<script>

function modalEditarUsuario(id, nome, telefone , endereco, bairro, cep, observacoes, referencia, cidade, estado, senha, tipo){
	document.getElementById("form").action = "/adm/atualizarUsuario";
	var funcCliente = '';
	var index = 0
	if(tipo == 'admin'){
		index = 0;
		funcCliente = 'funcionario';
	}else if(tipo == 'cliente'){
		index = 1;
		funcCliente = 'cliente';
	}else if(tipo == 'funcionario'){
		index = 2;
		funcCliente = 'funcionario';
	}else if(tipo == 'visitante'){
		index = 3;
		funcCliente = 'cliente';
	}
	document.getElementById("permissaoFunc").selectedIndex = index;
	document.getElementById("ID").value = id;
	document.getElementById("nome").value = nome;
	document.getElementById("alterarSalvar").value = 'editar';
	document.getElementById("funcCliente").value = funcCliente;
	
	document.getElementById("telefone").value = telefone;
	document.getElementById("telefone").required = false;
	document.getElementById("endereco").value = endereco;
	document.getElementById("endereco").required = false;
	document.getElementById("bairro").value = bairro;
	document.getElementById("bairro").required = false;
	document.getElementById("cep").value = cep;
	document.getElementById("senha").value = senha;
	document.getElementById("senhaRepetida").value = senha;
	document.getElementById("cep").required = false;
	document.getElementById("senha").required = true;
	document.getElementById("senhaRepetida").required = true;
	document.getElementById("observacoes").value = observacoes;
	document.getElementById("observacoes").required = false;
	document.getElementById("referencia").value = referencia;
	document.getElementById("referencia").required = false;
	document.getElementById("cidade").value = cidade;
	document.getElementById("cidade").required = false;
	document.getElementById("estado").value = estado;
	document.getElementById("estado").required = false;
	
	$("#modalEditarFuncionario").modal().show();
}

function modalNovoUsuario(){
	document.getElementById("form").action = "/adm/atualizarUsuario";
	document.getElementById("nome").value = '';
	document.getElementById("nome").required = true;
	document.getElementById("alterarSalvar").value = 'novo';
	document.getElementById("permissaoFunc").required = true;
	document.getElementById("funcCliente").value = funcCliente;
	document.getElementById("telefone").value = '';
	document.getElementById("telefone").required = false;
	document.getElementById("endereco").value = '';
	document.getElementById("endereco").required = false;
	document.getElementById("bairro").value = '';
	document.getElementById("bairro").required = false;
	document.getElementById("cep").value = '';
	document.getElementById("senha").value = '';
	document.getElementById("senha").required = true;
	document.getElementById("senhaRepetida").value = '';
	document.getElementById("senhaRepetida").required = true;
	document.getElementById("cep").required = false;
	document.getElementById("observacoes").value = '';
	document.getElementById("observacoes").required = false;
	document.getElementById("referencia").value = '';
	document.getElementById("referencia").required = false;
	document.getElementById("cidade").value = 'S�o Paulo';
	document.getElementById("cidade").required = false;
	document.getElementById("estado").value = 'SP';
	document.getElementById("estado").required = false;
	
	$("#modalEditarFuncionario").modal().show();
}


function modalPesquisarUsuario(){
	document.getElementById("form").action = "/adm/pesquisarUsuario";
	document.getElementById("nome").value = '';
	document.getElementById("nome").required = false;
	document.getElementById("permissaoFunc").required = false;
	document.getElementById("alterarSalvar").value = 'novo';
	document.getElementById("funcCliente").value = funcCliente;
	document.getElementById("telefone").value = '';
	document.getElementById("telefone").required = false;
	document.getElementById("endereco").value = '';
	document.getElementById("endereco").required = false;
	document.getElementById("bairro").value = '';
	document.getElementById("bairro").required = false;
	document.getElementById("cep").value = '';
	document.getElementById("cep").required = false;
	document.getElementById("observacoes").value = '';
	document.getElementById("observacoes").required = false;
	document.getElementById("referencia").value = '';
	document.getElementById("referencia").required = false;
	document.getElementById("cidade").value = 'S�o Paulo';
	document.getElementById("cidade").required = false;
	document.getElementById("estado").value = 'SP';
	document.getElementById("estado").required = false;
	
	
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
						<option value="admin" >Admin</option>
						<option value="cliente" selected="selected">Cliente</option>
						<option value="funcionario" >Funcion�rio</option>
						<option value="visitante" >Visitante</option>				  	
				</select>
			</div>
		</div>
		<div class="input-group mb-3">
  			<div>
  			Telefone:
  			</div>
  			<div class="input-group mb-3">
  				<input type="text" id="telefone" name="telefone" placeholder="Celular" maxlength="14" minlength="14" onkeydown="javascript: fMasc( this, mTel );" class="form-control" >
			</div>
		</div>
		<div class="input-group mb-3">
  			<div>
  			Endere�o:
  			</div>
  			<div class="input-group mb-3">
  				<input class="form-control" id="endereco" name="endereco" type="text" required aria-describedby="inputGroup-sizing-default">
			</div>
		</div>
		<div class="input-group mb-3">
  			<div>
  			Bairro:
  			</div>
  			<div class="input-group mb-3">
  				<input class="form-control" id="bairro" name="bairro" type="text" required aria-describedby="inputGroup-sizing-default">
			</div>
		</div>
		<div class="input-group mb-3">
  			<div>
  			CEP:
  			</div>
  			<div class="input-group mb-3">
  				<input type="text" id="cep" name="cep" placeholder="CEP" maxlength="9" minlength="9" onkeydown="javascript: fMasc( this, mCEP );" class="form-control" >
  			</div>
		</div>
		<div class="input-group mb-3">
  			<div>
  			Refer�ncia:
  			</div>
  			<div class="input-group mb-3">
  				<input class="form-control" id="referencia" name="referencia" type="text" required aria-describedby="inputGroup-sizing-default">
			</div>
		</div>
		<div class="input-group mb-3">
  			<div>
  			Observa��es:
  			</div>
  			<div class="input-group mb-3">
  				<input class="form-control" id="observacoes" name="observacoes" type="text" required aria-describedby="inputGroup-sizing-default">
			</div>
		</div>
		<div class="input-group mb-3">
  			<div>
  			Cidade:
  			</div>
  			<div class="input-group mb-3">
  				<input class="form-control" id="cidade" name="cidade" value="S�o Paulo" type="text" required aria-describedby="inputGroup-sizing-default">
			</div>
		</div>
		<div class="input-group mb-3">
  			<div>
  			Estado:
  			</div>
  			<div class="input-group mb-3">
  				<input class="form-control" id="estado" name="estado" value="SP" type="text" required aria-describedby="inputGroup-sizing-default" maxlength="2" minlength="2">
			</div>
		</div>
		<div class="input-group mb-3">
  			<div>
  			Senha:
  			</div>
  			<div class="input-group mb-3">
  				<input class="form-control" id="senha" name="senha" type="password" aria-describedby="inputGroup-sizing-default" required>
			</div>
		</div>
		<div class="input-group mb-3">
  			<div>
  			Repita a senha:
  			</div>
  			<div class="input-group mb-3">
  				<input class="form-control" id="senhaRepetida" name="senhaRepetida" type="password" aria-describedby="inputGroup-sizing-default" required>
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


