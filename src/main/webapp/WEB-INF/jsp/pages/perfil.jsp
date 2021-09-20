<!-- HEADER -->
<jsp:include page="includes/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!-- HEADER -->

<jsp:include page="includes/modais/modalPerfil.jsp" />
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
	<h1 class="h4">Alteração de Perfil</h1>
	<div>
	<button class="shadow btn btn-sm btn-outline-dark" onclick="modalNovoPerfil()">Novo</button>
	<button class="shadow btn btn-sm btn-outline-dark" onclick="tableToExcel('tabela', 'Documento')"><i class="fas fa-download"></i></button>
	<button class="shadow btn btn-sm btn-outline-dark" onclick="modalUploadExcel('perfis')"><i class="fas fa-upload"></i></button>
	</div>
</div>
	<div style="overflow: auto; width: 100%">
	<table id="tabela" class="table table-striped table-bordered table-sm">
	<thead>
		<tr>
		<c:if test="${usuarioSessao.perfil.admin}">
			<th>Editar </th>
		</c:if>
		<th>Código </th><th>Descrição</th> 
		<c:if test="${usuarioSessao.perfil.admin}">
			<th>Excluir</th> 
		</c:if>
		
		
		<tr>
		<th><i class="fas fa-search"></i></th>
		<th><input type="text" id="filtro1"/></th>
		<th><input type="text" id="filtro2"/></th>
		<th></th>
		</tr>
		
		
	</thead>
	<tbody>
		<tr>
		<c:forEach items="${perfis}" var="p">
			<c:if test="${usuarioSessao.perfil.admin}">
				<c:if test="${p.admin == true}"><c:set var = "tipoPerfil" value = "admin"/></c:if>
				<c:if test="${p.cliente == true}"><c:set var = "tipoPerfil" value = "cliente"/></c:if>
				<c:if test="${p.funcionario == true}"><c:set var = "tipoPerfil" value = "funcionario"/></c:if>
				<c:if test="${p.visitante == true}"><c:set var = "tipoPerfil" value = "visitante"/></c:if>
				<td><i class="fas fa-edit" onclick="modalEditarPerfil(${p.perfilID}, '${p.descricao}', '${p.codigo}', '${tipoPerfil}')"></i></td>
			</c:if>
			<td>${p.codigo}  </td>
			<td>${p.descricao}</td>
			<c:if test="${usuarioSessao.perfil.admin}">
				<td><i class="fas fa-trash" onclick="modalDeletar('perfil', ${p.perfilID})" ></i></td>
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


