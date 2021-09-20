<!-- HEADER -->
<jsp:include page="includes/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- HEADER -->
<jsp:include page="includes/modais/modalProduto.jsp" />
<!-- TABELAS COM FILTRO -->
<jsp:include page="includes/jquery/filtro.jsp" />
<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.2.min.js"></script> 
<script type="text/javascript" src="includes/jquery/script.js"></script>
<!-- TABELAS COM FILTRO -->
<!-- DOWNLOAD EXCEL -->
<jsp:include page="includes/jquery/excel/downloadExcel.jsp" />
<!-- DOWNLOAD EXCEL -->
<!-- UPLOAD EXCEL -->
<jsp:include page="includes/modais/modalUploadExcel.jsp" />
<!-- UPLOAD EXCEL -->


<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
	<h1 class="h4">Produtos</h1>
	<div>
	<button class="shadow btn btn-sm btn-outline-dark" onclick="modalNovoProduto()">Novo</button>
	<button class="shadow btn btn-sm btn-outline-dark" onclick="tableToExcel('tabela', 'Documento')"><i class="fas fa-download"></i></button>
	<button class="shadow btn btn-sm btn-outline-dark" onclick="modalUploadExcel('produtos')"><i class="fas fa-upload"></i></button>
	</div>
</div>


<div style="overflow: auto; width: 100%">
	<table id="tabela" class="table table-striped table-bordered table-sm">
		<thead>
		<tr>
		<c:if test="${usuarioSessao.perfil.admin}">
			<th>Editar </th>
		</c:if> 
		<th>Ver </th>
		<th>Código</th><th>EAN</th><th>Descrição</th><th>Preço</th><th>Categoria</th><th>Promoção</th><th>Estoque
		</th><th>Fornecedor</th><th>Marca</th><th>Peso</th><th>Tipo</th><th>Unidades</th>
		<c:if test="${usuarioSessao.perfil.admin}">
			<th>Excluir</th> 
		</c:if>
		
		
		<tr>
		<th><i class="fas fa-search"></i></th>
		<th></th>
		<th><input type="text" id="filtro1"/></th>
		<th><input type="text" id="filtro2"/></th>
		<th><input type="text" id="filtro3"/></th>
		<th><input type="text" id="filtro4"/></th>
		<th><input type="text" id="filtro5"/></th>
		<th><input type="text" id="filtro6"/></th>
		<th><input type="text" id="filtro7"/></th>
		<th><input type="text" id="filtro8"/></th>
		<th><input type="text" id="filtro9"/></th>
		<th><input type="text" id="filtro10"/></th>
		<th><input type="text" id="filtro11"/></th>
		<th><input type="text" id="filtro12"/></th>
		<th></th>
		</tr>
		
		
		</thead>
		<tbody>
		<tr>
		
		
		<c:forEach items="${produtos}" var="p">
			<c:if test="${usuarioSessao.perfil.admin}">
				<td><i class="fas fa-edit" onclick="modalEditarProduto('${p.produtoID}','${p.codigo}','${p.ean}','${p.descricao}','${p.preco}','${p.categoria.descricao}','${p.precoPromocional}','${p.estoque}','${p.fornecedor}','${p.marca}','${p.peso}','${p.tipoPeso}','${p.unidades}','${p.imgPath}')"></i></td>
			</c:if>
			<td><i class="fas fa-camera" onclick="modalImagem('${p.imgPath}')" ></i></td>
			<td>${p.codigo}  
			<td>${p.ean}   
			<td>${p.descricao} 
			<td>${p.preco}
			<td>${p.categoria.descricao} 
			<td>${p.precoPromocional}
			<td>${p.estoque}
			<td>${p.fornecedor}
			<td>${p.marca}
			<td>${p.peso}
			<td>${p.tipoPeso}
			<td>${p.unidades} 
			<c:if test="${usuarioSessao.perfil.admin}">
				<td><i class="fas fa-trash" onclick="modalDeletar('produto', ${p.produtoID})" ></i></td>
			</c:if>
			<tr>	
		</c:forEach>
		</tbody>		
	</table>
	</div>
<br>



<!-- FOOTER -->
<jsp:include page="includes/footer.jsp" />
<!-- FOOTER -->

