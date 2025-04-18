🎬 Cinemapedia
Cinemapedia é um aplicativo Flutter que permite aos usuários explorar filmes populares, em cartaz, próximos lançamentos e muito mais. Utilizando a API do The Movie Database (TMDB), o aplicativo oferece uma experiência rica e interativa para os amantes do cinema.​
GitHub
Medium

🧱 Arquitetura Limpa (Clean Architecture)
Este projeto segue os princípios da Clean Architecture, promovendo uma separação clara de responsabilidades e facilitando a escalabilidade e manutenção do código.​

Camada de Apresentação (Presentation): Contém os widgets do Flutter e gerencia o estado da interface do usuário.

Camada de Domínio (Domain): Inclui as entidades e os casos de uso que representam as regras de negócio.

Camada de Dados (Data): Responsável por obter os dados de fontes externas, como APIs e bancos de dados locais.​

A estrutura do projeto é inspirada em boas práticas amplamente reconhecidas na comunidade Flutter.​

🚀 Funcionalidades
Listagem de filmes populares, em cartaz e próximos lançamentos

Detalhes completos de cada filme, incluindo sinopse, elenco e avaliações

Busca de filmes por título

Favoritar filmes para acesso rápido

Suporte a temas claro e escuro​
GitHub
+4
GitHub
+4
GitHub
+4

🛠️ Tecnologias Utilizadas
Flutter: Framework para desenvolvimento multiplataforma.

Riverpod: Gerenciamento de estado reativo.

Dio: Cliente HTTP para Dart.

Isar: Banco de dados NoSQL local para Flutter.

GoRouter: Gerenciamento de rotas declarativas.

Flutter SVG: Renderização de arquivos SVG.

Google Fonts: Integração com fontes do Google Fonts.​
GitHub
GitHub

📸 Capturas de Tela


⚙️ Como Executar
Clone o repositório:​

bash
Copiar
Editar
git clone https://github.com/Fabricio-Guima/cinemapedia.git
Navegue até o diretório do projeto:​

bash
Copiar
Editar
cd cinemapedia
Instale as dependências:​
GitHub

bash
Copiar
Editar
flutter pub get
Configure as variáveis de ambiente:​

Renomeie o arquivo .env.template para .env.

Adicione sua chave de API do TMDB no arquivo .env.​
GitHub
+3
GitHub
+3
GitHub
+3

Execute o aplicativo:​

bash
Copiar
Editar
flutter run
📄 Licença
Este projeto está licenciado sob a Licença MIT.​

