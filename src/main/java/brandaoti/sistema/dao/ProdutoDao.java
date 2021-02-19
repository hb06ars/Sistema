package brandaoti.sistema.dao;


import java.util.List;

import org.hibernate.annotations.NamedQuery;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import brandaoti.sistema.model.Produto;

public interface ProdutoDao extends JpaRepository<Produto, Integer> {
	@Query("from Produto p where p.ativo = 1 order by p.estoque desc ")
	List<Produto> filtro(@Param("filtro") String filtro);
	
	@Query(" from Produto where ativo = 1 and codigo = :codigo ")
	Produto porCodigo(@Param("codigo") String codigo);
	
	@Query(" from Produto where ativo = 1 and estoque > 0 order by estoque desc ")
	List<Produto> porNome();
	
	@Query(" from Produto where ativo = 1 and estoque > 0 order by estoque desc ")
	List<Produto> comEstoque();
	
	@Query(" from Produto where ativo = 1 order by estoque desc ")
	List<Produto> buscarAtivos();
	
	
	
	
}
