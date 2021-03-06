<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>



<!--  GR�FICO -->
<script>
window.onload = function () {
	
	CanvasJS.addCultureInfo("pt", 
		    {      
		      	decimalSeparator: ",",
		      	digitGroupSeparator: ".",                   
		      	days: ["Domingo", "Segunda", "Ter�a", "Quarta", "Quinta", "Sexta", "S�bado"],
		    	months: ["Janeiro", "Fevereiro","Mar�o","Abril","Maio","Junho","Julho,","Agosto","Setembro","Outubro","Novembro","Dezembro"],
				shortMonths: ["Jan", "Fev","Mar","Abr","Mai","Jun","Jul,","Ago","Set","Out","Nov","Dez"],
		    	shortDays: ["Seg","Ter","Qua","Qui","Sex"]
		    });
	

	
	
	var chart = new CanvasJS.Chart("chartContainer", {
	    backgroundColor: "transparent",
	    culture: "pt",
		animationEnabled: true,
		theme: "light2",
		title: {
			text: "Produtos mais vendidos"
		},
		axisX: {
			valueFormatString:"DD/MM"
		},
		axisY: {
			prefix: "",
			labelFormatter: addSymbols
		},
		toolTip: {
			shared: true
		},
		legend: {
			cursor: "pointer",
			itemclick: toggleDataSeries
		},
		data: [
			{
				type: "column",
				name: "Vendas",
				showInLegend: true,
				xValueFormatString: "DD MMMM YYYY",
				yValueFormatString: "#,##0",
				dataPoints: [
					<c:forEach items="${maisVendidos }" var="mv" varStatus="s">
					<c:if test="${s.index > 0 }">,</c:if>{x: new Date('<fmt:formatDate pattern="yyyy-MM-dddd" value="${mv.data }"/>'), y: ${mv.total}, name:'${mv.produtos.descricao}'}
					</c:forEach>
				]
			},
			
			
		]
	});
	chart.render();

	function addSymbols(e) {
		var order = Math.max(Math.floor(Math.log(e.value) / Math.log(1000)), 0);
		return CanvasJS.formatNumber(e.value / Math.pow(1000, order));
	}

	function toggleDataSeries(e) {
		if (typeof (e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
			e.dataSeries.visible = false;
		} else {
			e.dataSeries.visible = true;
		}
		e.chart.render();
	}

	}
</script>





<!--  GR�FICO -->
