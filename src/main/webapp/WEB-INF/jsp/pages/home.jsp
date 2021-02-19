<!-- HEADER -->
<jsp:include page="includes/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<!-- HEADER -->

<script>
function redirect(link){
	window.location.href = link;
}
</script>

<style>

.zoom {
  transition: transform .2s;
}

.zoom:hover {
  -ms-transform: scale(1.1); /* IE 9 */
  -webkit-transform: scale(1.1); /* Safari 3-8 */
  transform: scale(1.1); 
}
</style>




<div class="panel-body">
	<div class="row" align="center">
		<div class="col-md-3 form-group zoom">
			<div class="card" onclick="redirect('/adm/vendas')" style="cursor:pointer; width: 18rem; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
				  <img class="card-img-top" src="/img/vendas.png" alt="Card image cap">
				  <div class="card-body">
				    <h5 class="card-title" >Vendas</h5>
				    <p class="card-text" >Clique aqui para iniciar uma venda!</p>
				  </div>
			</div>
		</div>
		<div class="col-md-3 form-group zoom">
			<div class="card" onclick="redirect('/adm/produtos')" style="cursor:pointer; width: 18rem; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
				  <img class="card-img-top" src="/img/produtos.png" alt="Card image cap">
				  <div class="card-body">
				    <h5 class="card-title" >Produtos</h5>
				    <p class="card-text">Consulte seus produtos e estoque!</p>
				  </div>
			</div>
		</div>
		<div class="col-md-3 form-group zoom">
			<div class="card" onclick="redirect('/adm/todasVendas')" style="cursor:pointer; width: 18rem; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
				  <img class="card-img-top" src="/img/vendasimg.png" alt="Card image cap">
				  <div class="card-body">
				    <h5 class="card-title">Pesquisar Venda</h5>
				    <p class="card-text" >Veja o relatório de vendas e produtos!</p>
				  </div>
			</div>
		</div>
		<div class="col-md-3 form-group zoom">
			<div class="card" onclick="redirect('/adm/clientes')" style="cursor:pointer; width: 18rem; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
				  <img class="card-img-top" src="/img/usuarios.png" alt="Card image cap">
				  <div class="card-body">
				    <h5 class="card-title" >Clientes</h5>
				    <p class="card-text" >Clique aqui e cadastre seus clientes.</p>
				  </div>
			</div>
		</div>
	</div>
</div>






<br><br>
           
<!-- FOOTER -->
<jsp:include page="includes/footer.jsp" />
<!-- FOOTER -->

