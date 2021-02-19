package brandaoti.sistema.model;
import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name = "Perfil")
public class Perfil implements Serializable {
	
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue
	private Integer perfilID;
	@Column(name = "codigo", length=100)
	private String codigo;
	@Column(name = "descricao", length=100)
	private String descricao;
	@Column(name = "ativo")
	private Boolean ativo =  true;
	@Column(name = "admin")
	private Boolean admin = false;
	@Column(name = "funcionario")
	private Boolean funcionario = false;
	@Column(name = "cliente")
	private Boolean cliente = false;
	@Column(name = "visitante")
	private Boolean visitante = false;
	
	public Integer getPerfilID() {
		return perfilID;
	}
	public void setPerfilID(Integer perfilID) {
		this.perfilID = perfilID;
	}
	public String getCodigo() {
		return codigo;
	}
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}
	public String getDescricao() {
		return descricao;
	}
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	public Boolean getAtivo() {
		return ativo;
	}
	public void setAtivo(Boolean ativo) {
		this.ativo = ativo;
	}
	public Boolean getAdmin() {
		return admin;
	}
	public void setAdmin(Boolean admin) {
		this.admin = admin;
	}
	public Boolean getFuncionario() {
		return funcionario;
	}
	public void setFuncionario(Boolean funcionario) {
		this.funcionario = funcionario;
	}
	public Boolean getCliente() {
		return cliente;
	}
	public void setCliente(Boolean cliente) {
		this.cliente = cliente;
	}
	public Boolean getVisitante() {
		return visitante;
	}
	public void setVisitante(Boolean visitante) {
		this.visitante = visitante;
	}

}