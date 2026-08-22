package br.com.criptofinance.criptofinance.entity;

import jakarta.persistence.*;

import java.time.OffsetDateTime;
import java.util.UUID;

@Entity
@Table (name = "usuario")
public class Usuario {
    @Id
    @Column(name = "id_usuario")
    private UUID idusuario;

    private String nome;
    private String email;

    @Column(name= "data_cadastro")
    private OffsetDateTime DataCadastro;

    public OffsetDateTime getDataCadastro() {
        return DataCadastro;
    }

    public void setDataCadastro(OffsetDateTime dataCadastro) {
        DataCadastro = dataCadastro;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public UUID getIdusuario() {
        return idusuario;
    }

    public void setIdusuario(UUID idusuario) {
        this.idusuario = idusuario;
    }
}
