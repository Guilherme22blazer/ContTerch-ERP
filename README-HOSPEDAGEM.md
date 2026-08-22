# ContTech ERP — pacote completo de hospedagem

Este pacote contém a aplicação completa, o vídeo e a identidade visual atuais, a base SQLite íntegra, a chave privada necessária para ler os dados cifrados e a configuração de publicação com HTTPS.

## Requisitos

- Um servidor VPS Linux com Docker e Docker Compose.
- Um domínio ou subdomínio apontado para o IP do servidor.
- Portas 80 e 443 liberadas no firewall.
- Pelo menos 1 GB de memória e 10 GB de armazenamento.

Hospedagem compartilhada que aceita somente HTML estático não é suficiente, porque login, banco de dados, usuários, certificados e consultas fiscais dependem do servidor Python em execução contínua.

## Publicação em 7 passos

1. Envie a pasta extraída para uma área privada do servidor, por exemplo `/opt/conttech-erp`. Não use `public_html`.
2. No DNS, crie um registro `A` do domínio para o IP do servidor.
3. Copie `.env.example` para `.env`.
4. Abra `.env` e troque `SITE_ADDRESS` pelo domínio real, sem `https://` e sem barra no final.
5. Na pasta do pacote, execute `docker compose up -d --build`.
6. Aguarde cerca de um minuto e abra `https://seu-dominio`.
7. Use `ACESSO-INICIAL-PRIVADO.txt`, troque imediatamente as duas senhas e apague esse arquivo do servidor.

O Caddy solicita e renova o certificado HTTPS automaticamente. Enquanto o DNS não estiver pronto, remova temporariamente o arquivo `.env` e acesse `http://IP-DO-SERVIDOR`.

## Comandos úteis

- Iniciar ou atualizar: `docker compose up -d --build`
- Ver situação: `docker compose ps`
- Ver registros: `docker compose logs -f --tail=200`
- Reiniciar: `docker compose restart`
- Parar: `docker compose down`
- Gerar backup consistente: `sh scripts/backup.sh`

## Banco de dados e arquivos privados

- Banco: `app/data/simplescalc.db`
- Chave de criptografia: `app/data/.gestao-fiscal.key`
- Os dois arquivos devem permanecer juntos nos backups.
- A aplicação e o proxy bloqueiam acesso web à pasta `data`.
- O banco incluído teve sessões e códigos de recuperação expirados/abertos removidos; os cadastros, permissões, planos, auditoria e informações fiscais foram preservados.

Nunca publique o ZIP, o banco, a chave ou `ACESSO-INICIAL-PRIVADO.txt` em repositório público. Restrinja o acesso ao servidor e faça backup diário fora da máquina principal.

## Restauração de backup

1. Execute `docker compose stop app`.
2. Renomeie o banco atual para manter uma cópia de segurança.
3. Copie `simplescalc.db` e `.gestao-fiscal.key` do backup para `app/data/`.
4. Execute `docker compose start app`.
5. Confira a tela de login e os dados antes de apagar a cópia anterior.

## Consulta oficial de CNPJ

Para usar a API oficial contratada do SERPRO, preencha no arquivo `.env`:

```text
SERPRO_CNPJ_CONSUMER_KEY=sua_chave
SERPRO_CNPJ_CONSUMER_SECRET=seu_segredo
```

Depois execute `docker compose up -d` novamente. Não coloque essas credenciais em HTML, JavaScript ou repositório público.

## Segurança e LGPD antes da divulgação

- Troque todas as senhas temporárias.
- Mantenha apenas os usuários realmente autorizados.
- Ative backup externo e teste uma restauração.
- Use HTTPS e não abra a porta interna 4173 no firewall.
- Restrinja o acesso SSH por chave e mantenha o sistema operacional atualizado.
- Configure política de privacidade, base legal, retenção, atendimento ao titular e resposta a incidentes conforme a operação real.
- Valide as integrações fiscais e os certificados A1 em ambiente controlado antes do uso em produção.

## Estrutura

- `app/`: aplicação ContTech ERP completa.
- `app/data/`: banco e chave cifrada; área privada e persistente.
- `Dockerfile`: imagem do servidor Python.
- `docker-compose.yml`: aplicação e HTTPS.
- `Caddyfile`: proxy, compressão e cabeçalhos de segurança.
- `scripts/backup.sh`: backup consistente do banco e da chave.
- `MANIFESTO-SHA256.txt`: conferência de integridade dos arquivos.
