<!-- HEADER -->
<jsp:include page="includes/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="css/simple-sidebar.css" rel="stylesheet">
<!-- HEADER -->

<jsp:include page="includes/modais/modalCancelarVenda.jsp" />
<!-- SCRIPT -->
<script>
function adicionarProduto(){
	if(document.getElementById("numPedido").innerHTML.includes('-')){
		mensagemErro('Venda','Favor iniciar a venda');
	}
	else if(document.getElementById("descricaoProduto").innerHTML == ('') || document.getElementById("descricaoProduto").innerHTML == null){
		mensagemErro('Venda','Selecione um produto.');	
	}
	else if (document.getElementById("quantidade").value < 1){
		mensagemErro('Venda','Quantidade incorreta.');	
	}
	else{
		/*Inserindo produtos no Carrinho*/
		var qtd = document.getElementById("quantidade").value;
		var subtotal = document.getElementById("subTotalSelecionado").value;
		document.getElementById("subTotalSelecionado").value = document.getElementById("valorSelecionado").value * qtd;
		var codigo = document.getElementById("codigoSelecionado").value;
		
		var table = document.getElementById("listaProdutos");
		var linhas = table.getElementsByTagName('tr').length;
		
		
		var repetido = 0;
		for(var i = 0; i < linhas; i++){
			try{
				var str = table.rows[i].cells[0].innerHTML;
				if( str == codigo ){
					repetido = 1;
					/*Quando o produto for repetido.*/
					var qtdAtual = table.rows[i].cells[3].innerHTML;
					table.rows[i].cells[3].innerHTML = parseInt(qtd) + parseInt(qtdAtual);
					var subTotalAtual = table.rows[i].cells[4].innerHTML;
					table.rows[i].cells[4].innerHTML = parseFloat(subtotal) + parseFloat(subTotalAtual);
					total = parseFloat(document.getElementById("totalVenda").innerHTML);
					subtotal = parseFloat(table.rows[i].cells[4].innerHTML);	
					/*Fim quando produto for repetido*/
				}
			}catch(e){}
		}
		
		if(repetido == 0){
			var row = table.insertRow(linhas-1);
			var cell0 = row.insertCell(0);
			var cell1 = row.insertCell(1);
			var cell2 = row.insertCell(2);
			var cell3 = row.insertCell(3);
			var cell4 = row.insertCell(4);
			var cell5 = row.insertCell(5);
			
			cell0.innerHTML = document.getElementById("codigoSelecionado").value;
			cell1.innerHTML = document.getElementById("descricaoProduto").innerHTML;
			cell2.innerHTML = document.getElementById("valorSelecionado").value;
			cell3.innerHTML = document.getElementById("quantidade").value;
			cell4.innerHTML = document.getElementById("subTotalSelecionado").value;
			var codigoStr = "\""+codigo+"\"";
			cell5.innerHTML = "<i class='fas fa-trash' onClick='removerCelula("+codigoStr+")'></i>";
			var subtotal = parseFloat(document.getElementById("subTotalSelecionado").value);
		}
		
		calcularTotal();
	
	}
}

function calcularTotal(){
	/*Calculando o TOTAL*/
	var table = document.getElementById("listaProdutos");
	linhas = table.getElementsByTagName('tr').length;
	var total = 0;
	for(var i = 0; i < linhas; i++){
		try{
			if(parseFloat(table.rows[i].cells[4].innerHTML) > 0){
				total = parseFloat(total) + parseFloat(table.rows[i].cells[4].innerHTML);	
			}
		}catch(ex){}
	}
	document.getElementById("totalVenda").innerHTML = parseFloat(total.toFixed(2));
}

function removerCelula(item){
	var table = document.getElementById("listaProdutos");
	var linhas = table.getElementsByTagName('tr').length;  
	var rowDel;
	for(var i = 2; i < linhas; i++){
		try{
			var str = table.rows[i].cells[0].innerHTML;
			while( str.substring(0,1) == '0'){
				str = str.substr(1);
			}
			while( item.substring(0,1) == '0'){
				item = item.substr(1);
			}
			if( str == item ){
				rowDel = table.deleteRow(i);
			}
		}catch(e){}
	}
	calcularTotal();
}



function finalizandoVenda(){
	document.getElementById("pedidoVenda").value = document.getElementById("numPedido").innerHTML;
	document.getElementById("notaDataVenda").value = document.getElementById("notaData").innerHTML;
	document.getElementById("valorTotalVenda").value = document.getElementById("totalVenda").innerHTML;
	
	var table = document.getElementById("listaProdutos");
	var linhas = table.getElementsByTagName('tr').length;
	var codigosVenda = '';
	var quantidadesVenda = '';
	var venda = '{"Produtos":[';
	for(var i = 3; i < (linhas-1); i++){
		venda = venda + "{\"codigo\":\"" + table.rows[i].cells[0].innerHTML + '\",';
		venda = venda + "\"qtd\":\"" + table.rows[i].cells[3].innerHTML + '\"},';
	}
	venda = venda.substring(0,(venda.length - 1));
	venda = venda+']}';
	document.getElementById("vendas").value = venda;
	imprimirNota()
	document.getElementById("formVenda").submit();
}

function imprimirNota(){
	/*IMPRIMINDO*/
	var divToPrint=document.getElementById("listaProdutos");
    newWin= window.open("");
    newWin.document.write(divToPrint.outerHTML);
    newWin.print();
    newWin.close();
}


function cancelarVenda(){
	var table = document.getElementById("listaProdutos");
	var linhas = table.getElementsByTagName('tr').length;  
	var rowDel;
		if(linhas > 4){
			for(var i = 0; i < linhas; i++){
				linhas = table.getElementsByTagName('tr').length;
				try{
					if(linhas > 4){
						linhas = table.getElementsByTagName('tr').length;
						rowDel = table.deleteRow(3);	
					}
				}catch(e){}
			}		
			document.getElementById("totalVenda").innerHTML = '0';
		}
		document.getElementById("numPedido").innerHTML = '-';
		document.getElementById("notaData").innerHTML = '-';
		document.getElementById("botaoInicia").innerText = "INICIAR VENDA";
}


function iniciar() {
	if(document.getElementById("botaoInicia").innerText == "INICIAR VENDA"){
		document.getElementById("botaoInicia").innerText = "FINALIZAR VENDA";
		document.getElementById('pesquisar').focus();
		var data = new Date(),
		dia  = data.getDate().toString(),
	    diaF = (dia.length == 1) ? '0'+dia : dia,
	    mes  = (data.getMonth()+1).toString(), //+1 pois no getMonth Janeiro começa com zero.
	    mesF = (mes.length == 1) ? '0'+mes : mes,
	    anoF = data.getFullYear(),
		valor = diaF+"/"+mesF+"/"+anoF;
		var hora = data.getHours() + "h" + data.getMinutes() + "m"+ " - OP: ${usuarioSessao}" ;
		var random = Math.floor(Math.random() * 100);
		document.getElementById("notaData").innerHTML = valor + " - " + hora;
		var pedido = anoF+mesF+diaF+data.getHours()+data.getMinutes()+data.getSeconds()+random;
		document.getElementById("numPedido").innerHTML = pedido;
		document.getElementById("totalVenda").value = 0;
		document.getElementById("totalVenda").innerHTML = "0";
		iniciandoVenda();
	} else{
		document.getElementById("botaoInicia").innerText = "INICIAR VENDA";
		finalizandoVenda();
	}
};


function categoria(categoriaID){
	document.getElementById("listaInicial1").style.visibility = "visible";
	document.getElementById("listaInicial2").style.visibility = "visible";
	document.getElementById("listaInicial1").style.display = "block";
	document.getElementById("listaInicial2").style.display = "block";
	
	var valoresCategoria = new Array();
	<c:forEach var="ca" items="${categorias}">
		valoresCategoria.push("${ca.categoriaID}");
	</c:forEach>
	
	var valoresProduto = new Array();
	<c:forEach var="pr" items="${produtos}">
		valoresProduto.push("${pr.produtoID}");
	</c:forEach>
	var remover = '';
	for(var i = 0 ; i < ${produtos.size()}; i++){
		for(var j = 0 ; j < ${categorias.size()}; j++){
			remover = "pr"+valoresProduto[i]+"cat"+valoresCategoria[j];
				if(categoriaID == valoresCategoria[j]){
					if (document.getElementById(remover)){
						document.getElementById(remover).style.display = "block";
						console.log("Removido: " + remover);
					}
				} else{
					if (document.getElementById(remover)){
						document.getElementById(remover).style.display = "none";	
						console.log("Removido: " + remover);
					}	
				}
		}	
	}
}

function produto(produtoID){
	var valoresProduto = new Array();
	document.getElementById("quantidade").focus();
	$('#quantidade').select();
	<c:forEach var="prod" items="${produtos}">
		if(${prod.produtoID} == produtoID){
			document.getElementById("codigoSelecionado").value = '${prod.codigo}';
			document.getElementById("valorSelecionado").value = '${prod.preco - prod.precoPromocional}';
			encontrado = 1;
			var precoVal = "R$ " + ${prod.preco}.toFixed(2).replace(".",",");
			var descontoVal = "R$ " + ${prod.precoPromocional}.toFixed(2).replace(".",",");
			document.getElementById("pesquisar").value = '${prod.ean}';
			document.getElementById("preco").innerHTML = precoVal;
			document.getElementById("descricaoProduto").innerHTML = '${prod.descricao}';
			document.getElementById("fotoProd").src = '${prod.imgPath}';
			if(${prod.precoPromocional > 0}){
				document.getElementById("preco").innerHTML = precoVal + '&nbsp&nbsp <l style="color:red" class="fas fa-gift"></l> <i style="color:red">-' + descontoVal+'</i>';
			} else{
				document.getElementById("preco").innerHTML = precoVal;	
			}
		}
	</c:forEach>
}


function pesquisaCodigo(){
	document.getElementById("quantidade").focus();
	var codigo = document.getElementById("pesquisar").value;
	var valoresProduto = new Array();
	<c:forEach var="prod" items="${produtos}">
		if(${prod.ean} == codigo){
			var precoVal = "R$ " + ${prod.preco}.toFixed(2).replace(".",",");
			var descontoVal = "R$ " + ${prod.precoPromocional}.toFixed(2).replace(".",",");
			document.getElementById("pesquisar").value = '${prod.ean}';
			document.getElementById("descricaoProduto").innerHTML = '${prod.descricao}';
			document.getElementById("fotoProd").src = '${prod.imgPath}';
			if(${prod.precoPromocional > 0}){
				document.getElementById("preco").innerHTML = precoVal + '<br><i style="color:red">Desconto:  -' + descontoVal+'</i>';
			} else{
				document.getElementById("preco").innerHTML = precoVal;	
			}
		}
	</c:forEach>
}

function imgProduto(){
	var link = document.getElementById("fotoProd").src;
	modalImagem(link);
}

</script>
<!-- SCRIPT -->

<jsp:include page="includes/css/cssVendas.jsp" />

<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
	<h1 class="h4">Vendas</h1>
	<div>
	<button class="shadow btn btn-sm btn-outline-dark" id="botaoInicia" onclick="iniciar()">INICIAR VENDA</button>
	<button class="shadow btn btn-sm btn-outline-dark" onclick="fullScreen()"><i class="fas fa-desktop"></i></button>
	<button class="shadow btn btn-sm btn-outline-dark" onclick="modalCancelarVenda()"><i class="fas fa-trash"></i></button>
	<a class="shadow btn btn-sm btn-outline-dark" href="/adm/todasVendas" ><i class="fas fa-search"></i></a>
	</div>
</div>

<input type=hidden id="codigoSelecionado" value="" />
<input type=hidden id="valorSelecionado" value="" />
<input type=hidden id="subTotalSelecionado" value="" />
z

<div style="overflow: auto; width: 100%">
	<table class="table">
		<tr>
			<td>Tipos </td>
			<td id="listaInicial1" style="visibility:hidden; display:none">Produto </td>
			<td> </td>
			<td>Nota Fiscal </td>
		</tr>
		<tr>
			
			
			<td style="min-width: 150px;">
				<div class="list-group list-group-flush">
					<c:forEach items="${categorias }" var="ca">
						<a onclick="categoria(${ca.categoriaID })" style="user-select: none;" class="list-group-item menuproduto">${ca.descricao }</a>
					</c:forEach>
		    	</div>
			</td>
			
			<td id="listaInicial2" style="min-width: 250px; visibility:hidden; display:none;" >
				<div class="list-group list-group-flush">
			        <c:forEach items="${produtos }" var="pr">
						<a onclick="produto(${pr.produtoID })" id="pr${pr.produtoID }cat${pr.categoria.categoriaID }" style="user-select: none; display:none;" class="list-group-item menuproduto">${pr.descricao }</a>
					</c:forEach>
		    	</div>
			</td>
			
			<td style="align:center; min-width: 300px;">
				<div class="list-group list-group-flush" >
			        <a class="list-group-item menuadicionar" onclick="adicionarProduto()" style="text-align:center; border-radius: 50px; color:white; cursor: pointer; user-select: none; ">Adicionar</a>
			        <br>
			        <div style="position:relative;left:25%;">
			        	<img class="card" onclick="imgProduto()" height="50%" width="50%" id="fotoProd" src="https://firebasestorage.googleapis.com/v0/b/sistema-202a2.appspot.com/o/Imagens%2FProdutos%2FsemFoto.png?alt=media&token=5cb4bf13-434f-4f13-b1b5-fd4aa726802e"></img>
			        </div>
			        <br>
			        	<div class="input-group mb-1">
				  			<input type="number" placeholder="Pesquisar" autofocus class="form-control" id="pesquisar" name="pesquisar" aria-describedby="inputGroup-sizing-default">
				  			<div class="input-group-prepend">
								<button class="btn btn-outline-secondary" onclick="pesquisaCodigo()" type="button" id="btPesquisar"><i class="fas fa-search"></i></button>
							</div>
						</div>

						<div class="input-group mb-1" >
							<div class="input-group mb-1">
	  							Quantidade:
	  						</div>
				  			<input type="number" placeholder="Quantidade" class="form-control" id="quantidade" min="1" step="any" name="quantidade" value="1" required aria-describedby="inputGroup-sizing-default">
						</div>
					<div class="input-group mb-1">
	  					<div class="input-group mb-1">
	  							<b>Preço: &nbsp </b>
	  							<b id="preco"></b>
	  						</div>
	  					<div id="descricaoProduto"></div>
	  				</div>
		    	</div>
			</td>				
			<td>
				<div class="nota grid-container" style="background-color:#FFFFFF;">  
			    		<div style="padding:10px;">
			    			<table id="listaProdutos" >
			    				<tr><td colspan="5">PEDIDO: <i id="numPedido">-</i> </td></tr>
			    				<tr><td colspan="5" id="notaData"> - </td></tr>
								<tr><td>Cód.</td><td>Descr.</td><td>Valor</td><td>Qtd.</td><td>SubTotal</td></tr>
								<tr><td colspan="5"><b>TOTAL: R$<i id="totalVenda"> - </i></b></td></tr>
							</table>
						</div>
			      	</div>
			</td>
		</tr>		
	</table>
</div>


<form action="<c:url value='/adm/finalizarVenda'/>" id="formVenda" method="post" >
	<input type="hidden" id="pedidoVenda" name="pedidoVenda" />
	<input type="hidden" id="notaDataVenda" name="notaDataVenda" />
	<input type="hidden" id="valorTotalVenda" name="valorTotalVenda" />
	<input type="hidden" id="vendas" name="vendas" value=""/>
</form>

	
<br><br>
<!-- FOOTER -->
<jsp:include page="includes/footer.jsp" />
<!-- FOOTER -->

