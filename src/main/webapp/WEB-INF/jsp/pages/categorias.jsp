<!-- HEADER -->
<jsp:include page="includes/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!-- HEADER -->

<jsp:include page="includes/modais/modalCategoria.jsp" />
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


<div
	class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-1 mb-3 border-bottom">
	<h1 class="h4">Altera��o de Categorias</h1>
	<div>
	<button class="shadow btn btn-sm btn-outline-dark" onclick="modalNovoCategoria()">Novo</button>
	<button class="shadow btn btn-sm btn-outline-dark" onclick="tableToExcel('tabela', 'Documento')"><i class="fas fa-download"></i></button>
	<button class="shadow btn btn-sm btn-outline-dark" onclick="modalUploadExcel('categorias')"><i class="fas fa-upload"></i></button>
	</div>
</div>
	<div style="overflow: auto; width: 100%">
	<table id="tabela" class="table table-striped table-bordered table-sm">
		<thead>
		<tr>
		<c:if test="${usuarioSessao.perfil.admin}">
			<th>Editar </th>
		</c:if>
		<th>C�digo </th><th>Descri��o</th> 
		<c:if test="${usuarioSessao.perfil.admin}">
			<th>Excluir</th> 
		</c:if>
		
		<tr>
		<th><i class="fas fa-search"></i></th>
		<th><input type="text" id="filtro1"/></th>
		<th><input type="text" id="filtro2"/></th>
		<th></th>
		</tr>
		
		
		<thead>
		<tbody>
		<tr>
		<c:forEach items="${categorias}" var="ca">
			<c:if test="${usuarioSessao.perfil.admin}">
				<td><i class="fas fa-edit" onclick="modalEditarCategoria(${ca.categoriaID}, '${ca.descricao}', '${ca.codigo}')"></i></td>
			</c:if>
			<td>${ca.codigo}  </td>
			<td>${ca.descricao}</td>
			<c:if test="${usuarioSessao.perfil.admin}">
				<td><i class="fas fa-trash" onclick="modalDeletar('categoria', ${ca.categoriaID})" ></i></td>
			</c:if>
			<tr>	
		</c:forEach>
			
			
			
	<tbody>		
	</table>
	
	</div>
<br>
<!-- FOOTER -->
<jsp:include page="includes/footer.jsp" />
<!-- FOOTER -->


