<!-- HEADER -->
<jsp:include page="includes/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!-- HEADER -->

<!-- MODAL USUARIO -->
<jsp:include page="includes/modais/modalUsuario.jsp" />
<jsp:include page="includes/modais/modalPesquisarOutraVenda.jsp" />
<jsp:include page="includes/modais/modalPesquisarVenda.jsp" />
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
	class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
	<h1 class="h4">Vendas</h1>
	<div>
	<button class="shadow btn btn-sm btn-outline-dark" onclick="tableToExcel('tabela', 'Documento')"><i class="fas fa-download"></i></button>
	<button class="shadow btn btn-sm btn-outline-dark" onclick="modalPesquisarOutraVenda()"><i class="fas fa-search"></i></button>
	</div>
</div>


<div style="overflow: auto; width: 100%" class="">
	<table id="tabela" class="table table-striped table-bordered table-sm">
		<thead>
		<tr>
		<th>Ver
		<c:if test="${perfilSessao.admin}">
			<th>Deletar
		</c:if> 
		<th>Pedido</th><th>Data</th><th>Funcionário</th><th>Total</th>
		
		<tr>
		<th></th>
		<c:if test="${perfilSessao.admin}">
			<th></th>
		</c:if>
		<th><input type="text" id="filtro1"/></th>
		<th><input type="text" id="filtro2"/></th>
		<th><input type="text" id="filtro3"/></th>
		<th><input type="text" id="filtro4"/></th>
		<th></th>
		</tr>
		
		
		</thead>
		<tbody>
		<tr>
		<c:forEach items="${vendas}" var="v">
			
			<td><i class="fas fa-search" onclick="modalPesquisarVenda('${v.pedido}')"></i></td>
			
			<c:if test="${perfilSessao.admin}">
				<td><i class="fas fa-trash" onclick="modalDeletar('venda','${v.pedido}')"></i></td>
			</c:if>
			
			<td>${v.pedido}
			<td>
			<c:set var = "data" value = "${fn:substring(v.data, 8, 10)}/${fn:substring(v.data, 5, 7)}/${fn:substring(v.data, 0, 4)}" />
			${data} 
			
			<td>${v.funcionario.nome} 
			
			<td><fmt:formatNumber maxFractionDigits="2" value="${v.total}" type="currency"/>
			<tr>	
		</c:forEach>
		</tbody>
	</table>
	</div>
<br>

<form action="<c:url value='/adm/todasVendas'/>" id="formPesqVenda" method="post" >
	<input type="hidden" name="pesquisarVendaID" id="pesquisarVendaID">
</form>
<!-- FOOTER -->
<jsp:include page="includes/footer.jsp" />
<!-- FOOTER -->

