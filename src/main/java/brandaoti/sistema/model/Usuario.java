package brandaoti.sistema.model;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;



@Entity
@Table(name = "Usuario")
public class Usuario implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue
	private Integer ID;
	@Column(name = "nome",length = 100, nullable = true)
	private String nome;
	@Column(name = "login",nullable = true)
	private String login;
	@Column(name = "email",length = 100, nullable = true)
	private String email;
	@Column(name = "senha",length = 50, nullable = true)
	private String senha;
	@Column(name = "ativo",nullable = true)
	private Boolean ativo = true;
	@Column(name = "codigo",nullable = true)
	private String codigo;
	@Column(name = "telefone",nullable = true)
	private String telefone;
	@Column(name = "endereco",nullable = true)
	private String endereco;
	
	@Column(name = "bairro",nullable = true)
	private String bairro;
	@Column(name = "cep",nullable = true)
	private String cep;
	@Column(name = "observacoes",nullable = true)
	private String observacoes;
	@Column(name = "referencia",nullable = true)
	private String referencia;
	@Column(name = "cidade",nullable = true)
	private String cidade;
	@Column(name = "estado",nullable = true)
	private String estado;
	
	
	@ManyToOne
	private Perfil perfil;
	
	
	public Integer getID() {
		return ID;
	}
	public void setID(Integer iD) {
		ID = iD;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getLogin() {
		return login;
	}
	public void setLogin(String login) {
		this.login = login;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getSenha() {
		return senha;
	}
	public void setSenha(String senha) {
		this.senha = senha;
	}
	public Boolean getAtivo() {
		return ativo;
	}
	public void setAtivo(Boolean ativo) {
		this.ativo = ativo;
	}
	public String getCodigo() {
		return codigo;
	}
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public Perfil getPerfil() {
		return perfil;
	}
	public void setPerfil(Perfil perfil) {
		this.perfil = perfil;
	}
	public String getTelefone() {
		return telefone;
	}
	public void setTelefone(String telefone) {
		this.telefone = telefone;
	}
	public String getEndereco() {
		return endereco;
	}
	public void setEndereco(String endereco) {
		this.endereco = endereco;
	}
	public String getBairro() {
		return bairro;
	}
	public void setBairro(String bairro) {
		this.bairro = bairro;
	}
	public String getCep() {
		return cep;
	}
	public void setCep(String cep) {
		this.cep = cep;
	}
	public String getObservacoes() {
		return observacoes;
	}
	public void setObservacoes(String observacoes) {
		this.observacoes = observacoes;
	}
	public String getReferencia() {
		return referencia;
	}
	public void setReferencia(String referencia) {
		this.referencia = referencia;
	}
	public String getCidade() {
		return cidade;
	}
	public void setCidade(String cidade) {
		this.cidade = cidade;
	}
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
		this.estado = estado;
	}
	
	
}