package brandaoti.sistema.dao;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import brandaoti.sistema.model.Perfil;

public interface PerfilDao extends JpaRepository<Perfil, Integer> {
	@Query(" from Perfil where ativo = 1 order by codigo asc ")
	List<Perfil> filtro(@Param("filtro") String filtro);
	
	@Query(" from Perfil where ativo = 1 and descricao = :descricao ")
	Perfil porNome(@Param("descricao") String descricao);
	
	@Query(" from Perfil where ativo = 1 order by codigo asc")
	List<Perfil> ativos();
	
	@Query(" from Perfil where ativo = 1 and admin = true order by codigo asc")
	List<Perfil> buscarAdm();
	
	@Query(" from Perfil where ativo = 1 and admin = true order by codigo asc")
	List<Perfil> buscarFuncionario();
	
	@Query(" from Perfil where ativo = 1 and funcionario = true order by codigo asc")
	List<Perfil> buscarCliente();
	
	@Query(" from Perfil where ativo = 1 and visitante = true order by codigo asc")
	List<Perfil> buscarVisitante();
	
	
	
	
}
