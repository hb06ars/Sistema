package brandaoti.sistema.model;
import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name = "Categoria")
public class Categoria implements Serializable {
	
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue
	private Integer categoriaID;
	@Column(name = "codigo", length=100)
	private String codigo;
	@Column(name = "descricao", length=100)
	private String descricao;
	@Column(name = "ativo")
	private Boolean ativo =  true;

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
	public Integer getCategoriaID() {
		return categoriaID;
	}
	public void setCategoriaID(Integer categoriaID) {
		this.categoriaID = categoriaID;
	}
	
	
}