package brandaoti.sistema.dao;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import brandaoti.sistema.model.Categoria;
import brandaoti.sistema.model.Perfil;

public interface CategoriaDao extends JpaRepository<Categoria, Integer> {
	
	@Query(" from Categoria where ativo = 1 and codigo = :codigo ")
	Categoria porCodigo(@Param("codigo") String codigo);
	
	@Query(" from Categoria where ativo = 1 and descricao = :descricao ")
	Categoria porNome(@Param("descricao") String descricao);
	
	@Query(" from Categoria where ativo = 1 ")
	List<Categoria> filtro(@Param("filtro") String filtro);
	
	@Query(" from Categoria where ativo = 1 ")
	List<Categoria> buscarAtivos();
	
	
	
	
}
