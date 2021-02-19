package brandaoti.sistema.dao;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import brandaoti.sistema.model.Usuario;

public interface UsuarioDao extends JpaRepository<Usuario, Integer> {
	@Query(" from Usuario where ativo = 1 order by codigo asc ")
	List<Usuario> filtro(@Param("filtro") String filtro);
	
	@Query(" from Usuario where ativo = 1 and (codigo like :codigo or email like :email or login like :login) ")
	List<Usuario> usuarioInvalido(@Param("codigo") String codigo, @Param("email") String email, @Param("login") String login);
	
	@Query(" from Usuario where ativo = 1 and login = :login and senha = :senha ")
	Usuario findByLoginAndPassword(@Param("login") String login, @Param("senha") String senha);
	
	@Query(" from Usuario where ativo = 1 and (perfil.admin = true or perfil.funcionario = true) order by nome ")
	List<Usuario> funcionariosAtivos();
	
	@Query(" from Usuario where ativo = 1 and (perfil.cliente = true) order by nome ")
	List<Usuario> clientesAtivos();
	
	
	
	
	
}
