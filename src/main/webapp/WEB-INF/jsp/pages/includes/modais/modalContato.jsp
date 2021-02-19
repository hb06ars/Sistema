<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>


<!--  CONTATO -->
<script>
function modalContato(){
	$("#modalContato").modal().show();
}
</script>

<div class="modal fade" id="modalContato" tabindex="-1" role="dialog" aria-labelledby="TituloModalCentralizado" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="TituloModalCentralizado">Contato</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        Endere�o da sua empresa, 123 - Jd. da Alegria <br>
        CEP: 00099-222 <br>
        S�o Paulo - SP <br>
        Contato: (11)99999-8888 / (11)99999-8888 <br>
        Email: email/empresa.com.br <br><br>
        Funcionamento: <br>
        seg � sex - 08hs �s 20hs <br>
        s�b - 09hs �s 17hs <br>
        dom e feriados - 10hs �s 14hs
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
      </div>
    </div>
  </div>
</div>
<!--  FINAL CONTATO -->

