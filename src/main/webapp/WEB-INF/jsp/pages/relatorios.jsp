<!-- HEADER -->
<jsp:include page="includes/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
<!-- HEADER -->
<!-- GRAFICOS -->
<jsp:include page="includes/graficos/grafico.jsp" />
<!-- GRAFICOS -->
<!-- DOWNLOAD EXCEL -->
<jsp:include page="includes/jquery/excel/downloadExcel.jsp" />
<!-- DOWNLOAD EXCEL -->
<!-- FILTRO DE DATAS GRÁFICO -->
<jsp:include page="includes/modais/modalFiltroData.jsp" />
<!-- FILTRO DE DATAS GRÁFICO -->

<div
	class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
	<h1 class="h4">Relatórios</h1>
	<div>
		<a href="/adm/relatorios" class="shadow btn btn-sm btn-outline-dark">Vendas</a>
		<a href="/adm/relatoriosMaisVendidos" class="shadow btn btn-sm btn-outline-dark">Produtos mais vendidos</a>
		<button class="shadow btn btn-sm btn-outline-dark" onclick="modalFiltroData()"><i class="fas fa-search"></i></button>
	</div>
</div>

<div class="modal-body input-group mb-3">
	<div class="input-group mb-3">
		<div id="chartContainer" style="height: 100%; width: 100%;"></div>
	</div>
</div>

<!-- FOOTER -->
<jsp:include page="includes/footer.jsp" />
<!-- FOOTER -->

