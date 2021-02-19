package brandaoti.sistema.model;
import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;


public class ProdutosMaisVendidos {
	
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue
	private Integer maisVendidosID;
	
	@Column(columnDefinition="date")
	private Date data = new Date();
	
	private Long id;
	
	@ManyToOne
	private Produto produtos;
	
	private Double total;
	
	

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Integer getMaisVendidosID() {
		return maisVendidosID;
	}

	public void setMaisVendidosID(Integer maisVendidosID) {
		this.maisVendidosID = maisVendidosID;
	}

	public Date getData() {
		return data;
	}

	public void setData(Date data) {
		this.data = data;
	}

	public Produto getProdutos() {
		return produtos;
	}

	public void setProdutos(Produto produtos) {
		this.produtos = produtos;
	}

	public Double getTotal() {
		return total;
	}

	public void setTotal(Double total) {
		this.total = total;
	}
	
	
	
}