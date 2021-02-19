package brandaoti.sistema.model;
import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;


@Entity
@Table(name = "Venda")
public class Venda implements Serializable {
	
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue
	private Integer vendaID;
	
	@Column(columnDefinition="date")
	private Date data = new Date();
	
	private Boolean ativo = true;
	private String pedido;
	
	@ManyToOne
	private Produto produtos;
	
	private Integer quantidade;
	private Double precoUnit;
	private Double subtotal;
	private Double total;
	
	@ManyToOne
	private Usuario funcionario;

	private Boolean promocao;
	
	public Integer getVendaID() {
		return vendaID;
	}

	public void setVendaID(Integer vendaID) {
		this.vendaID = vendaID;
	}

	public Date getData() {
		return data;
	}

	public void setData(Date data) {
		this.data = data;
	}

	public Boolean getAtivo() {
		return ativo;
	}

	public void setAtivo(Boolean ativo) {
		this.ativo = ativo;
	}

	public String getPedido() {
		return pedido;
	}

	public void setPedido(String pedido) {
		this.pedido = pedido;
	}

	public Produto getProdutos() {
		return produtos;
	}

	public void setProdutos(Produto produtos) {
		this.produtos = produtos;
	}

	public Integer getQuantidade() {
		return quantidade;
	}

	public void setQuantidade(Integer quantidade) {
		this.quantidade = quantidade;
	}

	public Double getSubtotal() {
		return subtotal;
	}

	public void setSubtotal(Double subtotal) {
		this.subtotal = subtotal;
	}

	public Double getTotal() {
		return total;
	}

	public void setTotal(Double total) {
		this.total = total;
	}

	public Usuario getFuncionario() {
		return funcionario;
	}

	public void setFuncionario(Usuario funcionario) {
		this.funcionario = funcionario;
	}

	public Double getPrecoUnit() {
		return precoUnit;
	}

	public void setPrecoUnit(Double precoUnit) {
		this.precoUnit = precoUnit;
	}

	public Boolean getPromocao() {
		return promocao;
	}

	public void setPromocao(Boolean promocao) {
		this.promocao = promocao;
	}
	
}