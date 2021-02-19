package brandaoti.sistema.model;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;



@Entity
@Table(name = "Produto")
public class Produto implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue
	private Integer produtoID;
	@Column(name = "descricao",length = 100, nullable = true)
	private String descricao;
	@Column(name = "ativo",nullable = true)
	private Boolean ativo = true;
	@Column(name = "codigo",length = 100, nullable = true)
	private String codigo;
	@Column(name = "ean",length = 100, nullable = true)
	private String ean;
	@Column(name = "marca",nullable = true)
	private String marca;
	@Column(name = "fornecedor",length = 100, nullable = true)
	private String fornecedor;
	@Column(name = "estoque",length = 50, nullable = true)
	private Integer estoque = 0;
	@Column(name = "preco",nullable = true)
	private Double preco = 0.0;
	@Column(name = "precoPromocional",nullable = true)
	private Double precoPromocional = 0.0;
	@Column(name = "unidades",nullable = true)
	private Integer unidades = 1;
	@Column(name = "peso",nullable = true)
	private Double peso = 0.0;
	@Column(name = "tipoPeso",nullable = true)
	private String tipoPeso;
	@Column(name = "imgPath",nullable = true)
	private String imgPath;
	@ManyToOne
	private Categoria categoria;
	
	public Integer getProdutoID() {
		return produtoID;
	}
	public void setProdutoID(Integer produtoID) {
		this.produtoID = produtoID;
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
	public String getMarca() {
		return marca;
	}
	public void setMarca(String marca) {
		this.marca = marca;
	}
	public String getFornecedor() {
		return fornecedor;
	}
	public void setFornecedor(String fornecedor) {
		this.fornecedor = fornecedor;
	}
	public Integer getEstoque() {
		return estoque;
	}
	public void setEstoque(Integer estoque) {
		this.estoque = estoque;
	}
	public Double getPreco() {
		return preco;
	}
	public void setPreco(Double preco) {
		this.preco = preco;
	}
	public Double getPrecoPromocional() {
		return precoPromocional;
	}
	public void setPrecoPromocional(Double precoPromocional) {
		this.precoPromocional = precoPromocional;
	}
	public Integer getUnidades() {
		return unidades;
	}
	public void setUnidades(Integer unidades) {
		this.unidades = unidades;
	}
	public Double getPeso() {
		return peso;
	}
	public void setPeso(Double peso) {
		this.peso = peso;
	}
	public String getTipoPeso() {
		return tipoPeso;
	}
	public void setTipoPeso(String tipoPeso) {
		this.tipoPeso = tipoPeso;
	}
	public String getCodigo() {
		return codigo;
	}
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}
	public String getEan() {
		return ean;
	}
	public void setEan(String ean) {
		this.ean = ean;
	}
	public String getImgPath() {
		return imgPath;
	}
	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}
	public Categoria getCategoria() {
		return categoria;
	}
	public void setCategoria(Categoria categoria) {
		this.categoria = categoria;
	}
	
	
	
	
}