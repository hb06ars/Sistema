<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>




<!--  EDITAR PRODUTO -->
<script>
function modalEditarProduto(produtoID, codigo, ean, descricao, preco, categoria, precoPromocional, estoque, fornecedor, marca, peso, tipoPesoValor, unidades, imgPath){
	document.getElementById("form").action = "/adm/atualizarProduto";
	var index = 1;
	if(tipoPesoValor == 'l'){
		index = 1;
	}else if(tipoPesoValor == 'ml'){
		index = 2;
	}else if(tipoPesoValor == 'kg'){
		index = 3;
	}else if(tipoPesoValor == 'g'){
		index = 4;
	}

	var sel = document.getElementById("categoria");
	var text= sel.options[0].text;
	for(var i = 0; i <= '${categorias.size()}' ; i++){
		text= sel.options[i].text;
		if(text == categoria){
			document.getElementById("categoria").selectedIndex = i;
		}
		
	}
	document.getElementById("categoria").required = false;
	document.getElementById("codigo").readOnly = true;
	document.getElementById("ean").readOnly = true;
	document.getElementById("tipoPeso").selectedIndex = index;
	document.getElementById("codigo").value = codigo;
	document.getElementById("codigo").required = true;
	document.getElementById("ean").value = ean;
	document.getElementById("ean").required = true;
	document.getElementById("descricao").value = descricao;
	document.getElementById("descricao").required = true;
	document.getElementById("preco").value = preco;
	document.getElementById("precoPromocional").value = precoPromocional;
	document.getElementById("estoque").value = estoque;
	document.getElementById("estoque").required = true;
	document.getElementById("fornecedor").value = fornecedor;
	document.getElementById("marca").value = marca;
	document.getElementById("peso").value = peso;
	document.getElementById("unidades").value = unidades;
	document.getElementById("imgPath").value = imgPath;
	document.getElementById("produtoID").value = produtoID;
	document.getElementById("alterarSalvar").value = 'edita';
	$("#modalEditarProduto").modal().show();
}

function modalNovoProduto(){
	document.getElementById("form").action = "/adm/atualizarProduto";
	document.getElementById("codigo").value = '';
	document.getElementById("codigo").readOnly = false;
	document.getElementById("codigo").required = true;
	document.getElementById("ean").value = '';
	document.getElementById("ean").readOnly = false;
	document.getElementById("ean").required = true;
	document.getElementById("tipoPeso").selectedIndex = 0;
	document.getElementById("descricao").value = '';
	document.getElementById("descricao").readOnly = false;
	document.getElementById("descricao").required = true;
	document.getElementById("preco").value = 0;
	document.getElementById("preco").readOnly = false;
	document.getElementById("categoria").required = true;
	document.getElementById("categoria").selectedIndex = 0;
	document.getElementById("precoPromocional").required = true;
	document.getElementById("precoPromocional").readOnly = false;
	document.getElementById("precoPromocional").value = 0;
	document.getElementById("estoque").value = 0;
	document.getElementById("estoque").readOnly = false;
	document.getElementById("estoque").required = true;
	document.getElementById("fornecedor").value = '';
	document.getElementById("marca").value = '';
	document.getElementById("peso").value = '';
	document.getElementById("unidades").value = 1;
	document.getElementById("imgPath").value = '';
	document.getElementById("alterarSalvar").value = 'novo';
	$("#modalEditarProduto").modal().show();
}


function modalPesquisarProduto(){
	document.getElementById("form").action = "/adm/pesquisarProduto";
	document.getElementById("codigo").readOnly = false;
	document.getElementById("codigo").required = false;
	document.getElementById("codigo").value = '';
	document.getElementById("ean").readOnly = false;
	document.getElementById("ean").required = false;
	document.getElementById("ean").value = '';
	document.getElementById("tipoPeso").selectedIndex = '';
	document.getElementById("descricao").value = '';
	document.getElementById("descricao").readOnly = false;
	document.getElementById("descricao").required = false;
	document.getElementById("preco").value = '';
	document.getElementById("preco").readOnly = false;
	document.getElementById("preco").required = false;
	document.getElementById("categoria").selectedIndex = '';
	document.getElementById("categoria").required = false;
	document.getElementById("precoPromocional").value = '';
	document.getElementById("precoPromocional").readOnly = false;
	document.getElementById("precoPromocional").required = false;
	document.getElementById("estoque").value = '';
	document.getElementById("estoque").readOnly = false;
	document.getElementById("estoque").required = false;
	document.getElementById("fornecedor").value = '';
	document.getElementById("marca").value = '';
	document.getElementById("peso").value = '';
	document.getElementById("unidades").value = '';
	document.getElementById("imgPath").value = '';
	document.getElementById("imgPath").readOnly = false;
	document.getElementById("imgPath").required = false;
	document.getElementById("alterarSalvar").value = 'pesquisa';
	$("#modalEditarProduto").modal().show();
}
</script>


<form action="<c:url value='/adm/atualizarProduto'/>" id="form" method="post" >
<div class="modal fade" id="modalEditarProduto" tabindex="-1" role="dialog" aria-labelledby="TituloModalCentralizado" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="TituloModalCentralizado">Produto</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body input-group mb-3">
      	<div class="input-group mb-3">
  			<div>
  			Código:
  			</div>
  			<div class="input-group mb-3">
  				<input class="form-control" id="codigo" name="codigo" type="text" required aria-describedby="inputGroup-sizing-default">
			</div>
		</div>
		<div class="input-group mb-3">
  			<div>
  			EAN:
  			</div>
  			<div class="input-group mb-3">
  				<input class="form-control" id="ean" name="ean" type="text" required aria-describedby="inputGroup-sizing-default">
			</div>
		</div>
		<div class="input-group mb-3">
  			<div>
  			Descrição:
  			</div>
  			<div class="input-group mb-3">
  				<input class="form-control" id="descricao" name="descricao" type="text" required aria-describedby="inputGroup-sizing-default">
			</div>
		</div>
		<div class="input-group mb-3">
  			<div>
  			Preço:
  			</div>
  			<div class="input-group mb-3">
  				<input class="form-control" id="preco" name="preco" type="number" step="any" min="0" required aria-describedby="inputGroup-sizing-default">
			</div>
		</div>
		<div class="input-group mb-3">
  			<div>
  			Categoria:
  			</div>
  			<div class="input-group mb-3">
  				<select style="height=:100%; width=:100%" class="form-control" id="categoria" name="produto_categoria" aria-describedby="inputGroup-sizing-default" required>
						<option value="" >-- Selecione --</option>
						<c:forEach items="${categorias }" var="ca">
							<option value="${ca.categoriaID }" >${ca.descricao }</option>
						</c:forEach>
				</select>
			</div>
		</div>
		<div class="input-group mb-3">
  			<div>
  			Preço Promocional:
  			</div>
  			<div class="input-group mb-3">
  				<input class="form-control" id="precoPromocional" name="precoPromocional" type="number" step="any" min="0" aria-describedby="inputGroup-sizing-default">
			</div>
		</div>
		<div class="input-group mb-3">
  			<div>
  			Estoque:
  			</div>
  			<div class="input-group mb-3">
  				<input class="form-control" id="estoque" name="estoque" type="number" min="0" required aria-describedby="inputGroup-sizing-default">
			</div>
		</div>
		<div class="input-group mb-3">
  			<div>
  			Fornecedor:
  			</div>
  			<div class="input-group mb-3">
  				<input class="form-control" id="fornecedor" name="fornecedor" type="text" aria-describedby="inputGroup-sizing-default">
			</div>
		</div>
		<div class="input-group mb-3">
  			<div>
  			Marca:
  			</div>
  			<div class="input-group mb-3">
  				<input class="form-control" id="marca" name="marca" type="text" aria-describedby="inputGroup-sizing-default">
			</div>
		</div>
		<div class="input-group mb-3">
  			<div>
  			Peso:
  			</div>
  			<div class="input-group mb-3">
  				<input class="form-control" id="peso" name="peso" type="number" step="any" min="0" aria-describedby="inputGroup-sizing-default">
			</div>
		</div>
		<div class="input-group mb-3">
  			<div>
  			Tipo Peso:
  			</div>
  			<div class="input-group mb-3">
  				<select style="height=:100%; width=:100%" class="form-control" id="tipoPeso" name="tipoPeso" aria-describedby="inputGroup-sizing-default">
						<option value="" >-- Selecione --</option>
						<option value="l" >l</option>
						<option value="ml" >ml</option>
						<option value="kg" >Kg</option>
						<option value="g" >g</option>
						<option value="mg" >mg</option>				  	
				</select>
			</div>
		</div>
		<div class="input-group mb-3">
  			<div>
  			Unidades:
  			</div>
  			<div class="input-group mb-3">
  				<input class="form-control" id="unidades" name="unidades" type="number" min="0" aria-describedby="inputGroup-sizing-default">
			</div>
		</div>
		<div class="input-group mb-3">
  			<div>
  			Foto:
  			</div>
  			<div class="input-group mb-3">
  				<input class="form-control" id="imgPath" name="imgPath" type="text" placeholder="Insira o link da Foto." aria-describedby="inputGroup-sizing-default">
			</div>
		</div>
		
      </div>
      <div class="modal-footer">
      	<input type="hidden" name="alterarSalvar" id="alterarSalvar">
      	<input type="hidden" name="produtoID" id="produtoID">
      	<input type="submit" name="submit" class="btn btn-primary" value="Ok">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
      </div>
    </div>
  </div>
</div>
</form>
<!--  EDITAR PRODUTO -->


