package brandaoti.sistema.dao;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import brandaoti.sistema.model.Venda;

public interface VendaDao extends JpaRepository<Venda, Integer> {
	@Query(" from Venda where ativo = 1 and pedido = :pedido order by data desc ")
	List<Venda> porPedido(@Param("pedido") String pedido);
	
	@Query(" from Venda where ativo = 1 and pedido = :pedido order by data desc ")
	List<Venda> nota(@Param("pedido") String pedido);
	
	@Query(" from Venda where ativo = 1 and pedido = :pedido order by data desc ")
	List<Venda> notaSelecionada(@Param("pedido") String pedido);
	
	@Query(" from Venda where ativo = 1  ")
	List<Venda> filtro(@Param("filtro") String filtro);
	
	@Query(" from Venda where ativo = 1 order by pedido desc ")
	List<Venda> ultimas();
	
	
	
	
	
	
}
