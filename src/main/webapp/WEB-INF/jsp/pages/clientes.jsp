<!-- HEADER -->
<jsp:include page="includes/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<!-- HEADER -->

<!-- MODAL USUARIO -->
<jsp:include page="includes/modais/modalUsuario.jsp" />
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
	<h1 class="h4">Clientes</h1>
	<div>
	<button class="shadow btn btn-sm btn-outline-dark" onclick="modalNovoUsuario()">Novo</button>
	<button class="shadow btn btn-sm btn-outline-dark" onclick="tableToExcel('tabela', 'Documento')"><i class="fas fa-download"></i></button>
	<button class="shadow btn btn-sm btn-outline-dark" onclick="modalUploadExcel('clientes')"><i class="fas fa-upload"></i></button>
	</div>
</div>


<div style="overflow: auto; width: 100%" class="">
	<table id="tabela" class="table table-striped table-bordered table-sm">
		<thead>
		<tr>
		<c:if test="${perfilSessao.admin}">
			<th>Editar </th>
		</c:if> 
		<th>Nome</th>
		<th>Telefone</th><th>Endereco</th><th>Bairro</th><th>CEP</th><th>Observacoes</th><th>Referência</th><th>Cidade</th><th>Estado</th>
		<th>Perfil</th>
		<c:if test="${perfilSessao.admin}">
			<th>Excluir</th> 
		</c:if>
		
		<tr>
		<th><i class="fas fa-search"></i></th>
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
		<th></th>
		</tr>
		
		
		</thead>
		<tbody>
		<tr>
		<c:forEach items="${usuarios}" var="u">
			<c:if test="${perfilSessao.admin}">
				<c:if test="${u.perfil.cliente == true}"><c:set var = "tipoPerfilFunc" value = "cliente"/></c:if>
				<c:if test="${u.perfil.visitante == true}"><c:set var = "tipoPerfilFunc" value = "visitante"/></c:if>
				<td><i class="fas fa-edit" onclick="modalEditarUsuario(${u.ID}, '${u.nome}', '${u.telefone}' , '${u.endereco}', '${u.bairro}', '${u.cep}', '${u.observacoes}', '${u.referencia}' , '${u.cidade}' , '${u.estado}', '${u.senha}', '${tipoPerfilFunc}')"></i></td>
			</c:if>
			<td>${u.nome}   
			<td>${u.telefone}
			<td>${u.endereco}
			<td>${u.bairro}
			<td>${u.cep}
			<td>${u.observacoes}
			<td>${u.referencia}
			<td>${u.cidade}
			<td>${u.estado}
			<td>${u.perfil.descricao} 
			<c:if test="${perfilSessao.admin}">
				<td><i class="fas fa-trash" onclick="modalDeletar('cliente', ${u.ID})" ></i></td>
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

