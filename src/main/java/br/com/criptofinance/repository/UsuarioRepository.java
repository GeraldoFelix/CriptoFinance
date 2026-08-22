package br.com.criptofinance.repository;
import br.com.criptofinance.entity.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.UUID;

public interface UsuarioRepository extends JpaRepository<Usuario, UUID> {

}
