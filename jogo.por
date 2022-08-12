programa
{
	
	//bibliotecas do projeto
	inclua biblioteca Graficos --> g
	inclua biblioteca Teclado --> t
	inclua biblioteca Util --> u
	inclua biblioteca Arquivos --> a
	inclua biblioteca Tipos --> tp
	inclua biblioteca Texto --> txt
	
	//variáveis do projeto
	inteiro qtdAcertos = 0 //armazena a quantidade de acertos do jogador
	inteiro qtdErros = 0 //armazena a quantidade de erros do jogador
	inteiro qtdTentativas = 0 //calcula as tentativas do jogador
	inteiro arq //diretório do arquivo em modo leitura
	cadeia diretorio = "jogo.txt" //indica o arquivo das palavras e dicas
	cadeia arquivo[200] //armazena todas as linhas do arquivo
	cadeia palavras[100] //armazena todas as palavras lidas do arquivo
	cadeia matriz[100][11] //armazena todas as dicas
	inteiro cont = 0, posP = 0, numP = 0, colunas = 0, linhas = 0 //contadores 
	inteiro numSorteado, tamanhoP, tamanhoPF //variável para sortear um número, varíaveis para calcular os tamanhos da palavra
	cadeia palavraF, dicaF, palavra  //variável para armazenar a palavra e dica final após filtradas e varíavel para guardar a palavra
	caracter separacao[30], pJogador[30] //vetores para armazenar a palavra separada e os acertos do jogador dentro da separação
	caracter tracos[30] //vetor de traços do tamanho da palavra
	inteiro corTexto = g.criar_cor(203, 203, 203) //cor do texto branco
	inteiro corVermelho = g.criar_cor(144, 2, 2) //cor do texto vermelho
	inteiro corVerde = g.criar_cor(2, 144, 17) //cor do texto verde
	inteiro corFundo = g.criar_cor(146, 255, 179) //cor do fundo da janela
	inteiro corTextoMenu = g.criar_cor	(28,28,28) //cor do texto no menu principal
	inteiro digitoEnter = 0, digitoShift = 0, qtdDicas = 0,  dicaSorteio = 0 //calcula se enter ou shift foi digitado, soma a quantidade de dicas solicitada e sorteia uma dica
	inteiro qtdDicasExistentes = 0 //calcula quantas dicas existem para a palavra
	cadeia dica1 = "", dica2 = "", dica3 = "", dica4 = "" //armazena as dicas
	caracter letraEnviada = '-' //lê as letras que foram tecladas pelo jogador
	logico continuar = falso //dá permissão para o jogo continuar
	caracter tentativa1 = ' ', tentativa2 = ' ', tentativa3 = ' ', tentativa4 = ' ', tentativa5 = ' ', tentativa6 = ' ', tentativa7 = ' ' 
	caracter tentativa8 = ' ', tentativa9 = ' ', tentativa10 = ' ' //armazena as tentativas de 1 a 10
	
	/* FUNÇÃO PRINCIPAL DO JOGO */
	funcao inicio()
	{
		g.carregar_fonte("font.ttf") //carrega a fonte que será usada nos textos do jogo
		cadeia palavraRandom, dicaRandom, dicaRandom2[11] //variável que randomiza as palavras e dicas
		
		arq = a.abrir_arquivo(diretorio,a.MODO_LEITURA) //abre o arquivo em modo leitura
		
		enquanto(nao a.fim_arquivo(arq)) { //lê todas as linhas do arquivo e armazena em dicas ou palavras
		 	arquivo[cont] = a.ler_linha(arq)
			se (arquivo[cont] != "") { 
				se(txt.obter_caracter(arquivo[cont], 0) == 'P') { 
					palavras[posP] = arquivo[cont] 
					palavras[posP] = txt.caixa_alta(palavras[posP]) 
					linhas++
					colunas=0 
					numP++
					posP++ 
				} senao { 
		 			matriz[linhas][colunas] = arquivo[cont] 
		 			colunas++ 
		 		}
				cont++
			}
		 }
			
		a.fechar_arquivo(arq) //fechar arquivo

		//sortear palavras e dicas
		numSorteado = u.sorteia(0, (numP-1))
		palavraRandom = palavras[numSorteado] 
		dicaSorteio = numSorteado++

		//converter a palavra
		palavra = palavraFinal(palavraRandom)
		tamanhoPF = txt.numero_caracteres(palavra)

		//criar os traços e separar a palavra
		para (cont=0;cont<tamanhoPF;cont++) {
			pJogador[cont] = '_'
			separacao[cont] = txt.obter_caracter(palavra, cont)			
		}

		// armazenar as dicas
		se(matriz[numSorteado][10] == ""){
			qtdDicasExistentes = 10
		}
		se(matriz[numSorteado][9] == ""){
			qtdDicasExistentes = 9
		}
		se(matriz[numSorteado][8] == ""){
			qtdDicasExistentes = 8
		}
		se(matriz[numSorteado][7] == ""){
			qtdDicasExistentes = 7
		}
		se(matriz[numSorteado][6] == ""){
			qtdDicasExistentes = 6
		}
		se(matriz[numSorteado][5] == ""){
			qtdDicasExistentes = 5
		}
		se(matriz[numSorteado][4] == ""){
			qtdDicasExistentes = 4
		}
		se(matriz[numSorteado][3] == ""){
			qtdDicasExistentes = 3
		}
		se(matriz[numSorteado][2] == ""){
			qtdDicasExistentes = 2
		}
		
		para (cont=0;cont<qtdDicasExistentes;cont++) {
			dicaRandom = matriz[numSorteado][cont]
			dicaRandom2[cont] = dicaFinal(dicaRandom)

			se(qtdDicasExistentes == 2){
				dica1 = dicaRandom2[0]
				dica2 = dicaRandom2[1]
			}
			se(qtdDicasExistentes == 3){
				dica1 = dicaRandom2[0]
				dica2 = dicaRandom2[1]
				dica3 = dicaRandom2[2]
			}
			se(qtdDicasExistentes == 4){
				dica1 = dicaRandom2[0]
				dica2 = dicaRandom2[1]
				dica3 = dicaRandom2[2]
				dica4 = dicaRandom2[3]
			}
			
		
			
		}

		//traços da palavra
		para (cont=0;cont<tamanhoPF;cont++) {
			tracos[cont] = '_'			
		}
		
		//abrir o jogo em modo janela
		inicializar()

		//loop para as funções
		enquanto(verdadeiro){
			corJanela()
			menuPrincipal()
			
			se(t.tecla_pressionada(t.TECLA_ENTER)){
				digitoEnter = 10
			}
			se(digitoEnter == 10){
				painel()
				textos()
				personagem()
				tecla()
				verificarTempo()
				telaMorte()
				telaVitoria()
			}
			se(t.tecla_pressionada(t.TECLA_SHIFT)){
				digitoShift = 10
				shiftPressionado()
				qtdDicas++
			}
			verificarLetra()
			g.renderizar()
		}
	}
	
	/* FUNÇÕES */

	//função para inicializar a janela
	funcao inicializar(){
		const inteiro larguraJanela = 800
		const inteiro alturaJanela = 600
		
		g.iniciar_modo_grafico(verdadeiro)
		g.definir_dimensoes_janela(larguraJanela, alturaJanela)
		g.definir_titulo_janela("Jogo da Forca")
	}

	//função para personalizar a janela
	funcao corJanela(){
		g.definir_cor(corFundo)
		g.limpar()
		
	}
	//função do menu principal
	funcao menuPrincipal(){
		g.definir_cor(g.COR_PRETO)
		g.definir_fonte_texto("Gotham Ultra")
		g.definir_tamanho_texto(60.0)
		g.desenhar_texto(155, 250, "JOGO DA FORCA")
		g.desenhar_retangulo(220, 320, 400, 50, verdadeiro, verdadeiro)
		g.definir_cor(g.COR_BRANCO)
		g.definir_tamanho_texto(20.0)
		g.desenhar_texto(280, 337, "TECLE ENTER PARA INICIAR")
		g.definir_cor(corTextoMenu)
		g.desenhar_texto(50, 50, "Como jogar?")
		g.desenhar_texto(50, 70, "- Aperte a letra desejada + ENTER para fazer uma tentativa;")
		g.desenhar_texto(50, 90, "- Segure SHIFT + qualquer tecla para solicitar uma dica;")
		g.desenhar_texto(50, 110, "- A primeira dica não conta como erro, as próximas sim;")
		g.desenhar_texto(50, 130, "- Acerte a palavra em menos de 2 MINUTOS;")
		g.desenhar_texto(50, 150, "- Você tem 5 vidas;")
		
		g.desenhar_texto(50, 555, "Desenvolvido por:")
		g.desenhar_texto(280, 550, "Enzo Candido")
		g.desenhar_texto(280, 570, "Guilherme Da Silva Almeida")

	}

	//função do painel que contém os dados exibidos durante o jogo
	funcao painel(){
		const inteiro larguraJanela = 800
		
		digitoEnter = 10
		g.definir_cor(g.COR_PRETO)
		g.limpar()
		
		g.definir_cor(g.COR_BRANCO)
		g.desenhar_retangulo(10, 554, 36, 30, verdadeiro, verdadeiro)

		inteiro corRetangulo = g.criar_cor(146, 255, 179)
		g.definir_cor(corRetangulo)
		g.desenhar_retangulo(0, 55, larguraJanela, 480, falso, verdadeiro)
		
		g.definir_fonte_texto("Gotham Ultra")
		g.definir_cor(corVerde)
		g.definir_tamanho_texto(20.0)
		g.desenhar_texto(20, 20, "ACERTOS: " + qtdAcertos)
		
		g.definir_cor(corTexto)
		g.definir_tamanho_texto(20.0)
		g.desenhar_texto(330, 20, "TENTATIVAS: " + qtdTentativas)
		
		g.definir_cor(corVermelho)
		g.definir_tamanho_texto(20.0)
		g.desenhar_texto(680, 20, "ERROS: " + qtdErros)

		g.definir_cor(corTexto)
		g.definir_tamanho_texto(20.0)
		se(qtdDicas >= qtdDicasExistentes){
			g.definir_cor(corVermelho)
			g.desenhar_texto(450, 560, "Você não possui mais dicas.")
		} senao{
			g.desenhar_texto(400, 550, "Segure SHIFT + qualquer tecla")
			g.desenhar_texto(430, 570, "para receber uma dica!")
		}

		g.definir_cor(corTexto)
		g.definir_tamanho_texto(14.0)
		g.desenhar_texto(50, 563, "Aperte ENTER para confirmar a letra.")

		//fundo tabela dicas
		g.definir_cor(g.COR_PRETO)
		g.desenhar_retangulo(496, 75, 340, 290, verdadeiro, verdadeiro)
		g.definir_cor(corFundo)
		g.desenhar_retangulo(500, 80, 320, 280, verdadeiro, verdadeiro)
		

		se(qtdDicas == 0){
			g.definir_tamanho_texto(20.0)
			g.definir_cor(g.COR_PRETO)
			g.desenhar_texto(520, 220, "Nenhuma dica solicitada.")
		}
		
		g.definir_tamanho_texto(15.0)
		g.definir_fonte_texto("Arial")
		
		se(qtdDicas == 1){
			g.definir_cor(g.COR_PRETO)
			g.desenhar_texto(510, 150, dica1)
		}
		se(qtdDicas == 2){
			g.definir_cor(g.COR_PRETO)
			g.desenhar_texto(510, 150, dica1)
			
			g.definir_cor(g.COR_PRETO)
			g.desenhar_texto(510, 170, dica2)
		}
		se(qtdDicas == 3){
			g.definir_cor(g.COR_PRETO)
			g.desenhar_texto(510, 150, dica1)
			
			g.definir_cor(g.COR_PRETO)
			g.desenhar_texto(510, 170, dica2)
			
			g.definir_cor(g.COR_PRETO)
			g.desenhar_texto(510, 190, dica3)

		}
		se(qtdDicas == 4){
			g.definir_cor(g.COR_PRETO)
			g.desenhar_texto(510, 150, dica1)
			
			g.definir_cor(g.COR_PRETO)
			g.desenhar_texto(510, 170, dica2)
			
			g.definir_cor(g.COR_PRETO)
			g.desenhar_texto(510, 190, dica3)

			g.definir_cor(g.COR_PRETO)
			g.desenhar_texto(510, 210, dica4)
		}
		se(qtdDicas > 4){
			g.definir_cor(g.COR_PRETO)
			g.desenhar_texto(510, 150, dica1)
			
			g.definir_cor(g.COR_PRETO)
			g.desenhar_texto(510, 170, dica2)
			
			g.definir_cor(g.COR_PRETO)
			g.desenhar_texto(510, 190, dica3)

			g.definir_cor(g.COR_PRETO)
			g.desenhar_texto(510, 210, dica4)
		}
		
	}

	//função para mostrar os traços e as letras acertadas pelo jogador
	funcao textos(){
		cadeia tracosConvert
		inteiro posX = 0
		inteiro tamanhoPos
		cadeia acertosJogador

		tamanhoPos = txt.numero_caracteres(palavra)
		
		se(tamanhoPos == 1){
			posX = 370
		}
		se(tamanhoPos == 2){
			posX = 320
		}
		se(tamanhoPos == 3){
			posX = 280
		}
		se(tamanhoPos == 4){
			posX = 260
		}
		se(tamanhoPos == 5){
			posX = 230
		}
		se(tamanhoPos == 6){
			posX = 190
		}
		se(tamanhoPos == 7){
			posX = 140
		}
		se(tamanhoPos == 8){
			posX = 100
		}
		se(tamanhoPos == 9){
			posX = 65
		}
		se(tamanhoPos == 10){
			posX = 60
		}
		
		se(tamanhoPos > 10){
			posX = 40
		}
		
		g.definir_fonte_texto("Gotham Ultra")
		g.definir_cor(g.COR_PRETO)
		
		para (cont=0;cont<tamanhoPF;cont++) {
			g.definir_tamanho_texto(80.0)
			acertosJogador = tp.caracter_para_cadeia(pJogador[cont])
			g.desenhar_texto(posX, 400, acertosJogador)	
			posX = posX + 80	
		}
		
	}

	//função para filtrar as palavras
	funcao cadeia palavraFinal (cadeia palavraRandom) {
		tamanhoP = txt.numero_caracteres(palavraRandom)
		palavraF = txt.extrair_subtexto(palavraRandom, 3, tamanhoP)
		retorne palavraF
	}
	
	//função para filtrar as dicas
	funcao cadeia dicaFinal (cadeia dicaRandom) {
		
		tamanhoP = txt.numero_caracteres(dicaRandom)
		dicaF = txt.extrair_subtexto(dicaRandom, 3, tamanhoP) 
		retorne dicaF
	}

	//função que desenha o personagem do jogo
	funcao personagem(){
		g.definir_cor(g.COR_PRETO)
		g.desenhar_linha(410, 100, 200, 100) // parte de cima da forca
		g.desenhar_linha(410, 100, 410, 150) //corda da forca
		g.desenhar_linha(200, 100, 200, 150) //esquerda da forca
		g.desenhar_elipse(370, 150, 80, 80, falso) //cabeça
		
	}

	//função para a leitura das teclas
	funcao tecla(){
		inteiro digito
		caracter tDigito = '-'
		
		cadeia digitoF = ""
		
		digito = t.ler_tecla()

		escolha(digito)
		{
			caso 65:
			tDigito = 'A'
			pare
			caso 66:
			tDigito = 'B'
			pare
			caso 67:
			tDigito = 'C'
			pare
			caso 68:
			tDigito = 'D'
			pare
			caso 69:
			tDigito = 'E'
			pare
			caso 70:
			tDigito = 'F'
			pare
			caso 71:
			tDigito = 'G'
			pare
			caso 72:
			tDigito = 'H'
			pare
			caso 73:
			tDigito = 'I'
			pare
			caso 74:
			tDigito = 'J'
			pare
			caso 75:
			tDigito = 'K'
			pare
			caso 76:
			tDigito = 'L'
			pare
			caso 77:
			tDigito = 'M'
			pare
			caso 78:
			tDigito = 'N'
			pare
			caso 79:
			tDigito = 'O'
			pare
			caso 80:
			tDigito = 'P'
			pare
			caso 81:
			tDigito = 'Q'
			pare
			caso 82:
			tDigito = 'R'
			pare
			caso 83:
			tDigito = 'S'
			pare
			caso 84:
			tDigito = 'T'
			pare
			caso 85:
			tDigito = 'U'
			pare
			caso 86:
			tDigito = 'V'
			pare
			caso 87:
			tDigito = 'W'
			pare
			caso 88:
			tDigito = 'X'
			pare
			caso 89:
			tDigito = 'Y'
			pare
			caso 90:
			tDigito = 'Z'
			pare
		}

		se(t.tecla_pressionada(t.TECLA_SHIFT)){
			letraEnviada = '-'	
		} senao {
			letraEnviada = tDigito
			digitoF = tp.caracter_para_cadeia(letraEnviada)
		}
		
		g.definir_cor(g.COR_PRETO)
		g.definir_tamanho_texto(20.0)
		g.desenhar_texto(20, 560, digitoF)
		
	}
	
	//função para exibir as dicas
	funcao shiftPressionado(){
		escolha(qtdDicas){
			caso 1:
				
			pare
			caso 2:
				se(qtdDicas <= qtdDicasExistentes){
					qtdErros++
				}
			pare
			caso 3:
				se(qtdDicas <= qtdDicasExistentes){
					qtdErros++
				}
			pare
			caso 4:
				se(qtdDicas <= qtdDicasExistentes){
					qtdErros++
				}
			pare
		}	
		
	}

	//função da tela de derrota, desenha o personagem "morto"
	funcao telaMorte(){
		escolha(qtdErros){
			caso 0:
				
			pare
			caso 1:
				g.desenhar_linha(410, 230, 410, 310) //tronco
			pare
			caso 2:
				g.desenhar_linha(410, 230, 410, 310) //tronco
				g.desenhar_linha(410, 240, 380, 300) //braço esquerdo
			pare
			caso 3:
				g.desenhar_linha(410, 230, 410, 310) //tronco
				g.desenhar_linha(410, 240, 380, 300) //braço esquerdo
				g.desenhar_linha(410, 240, 440, 300) //braço direito
			pare
			caso 4:
				g.desenhar_linha(410, 230, 410, 310) //tronco
				g.desenhar_linha(410, 240, 380, 300) //braço esquerdo
				g.desenhar_linha(410, 240, 440, 300) //braço direito
				g.desenhar_linha(410, 310, 380, 380) //perna esquerda
			pare
			caso contrario:
				inteiro corFundo2 = g.criar_cor(115, 3, 3)
				g.definir_cor(corFundo2)
				g.limpar()
				g.definir_cor(g.COR_PRETO)
				g.desenhar_linha(410, 100, 200, 100) // parte de cima da forca
				g.desenhar_linha(410, 100, 410, 150) //corda da forca
				g.desenhar_linha(200, 100, 200, 150) //esquerda da forca
				g.desenhar_elipse(370, 150, 80, 80, falso) //cabeça
				g.desenhar_linha(410, 230, 410, 310) //tronco
				g.desenhar_linha(410, 240, 380, 300) //braço esquerdo
				g.desenhar_linha(410, 240, 440, 300) //braço direito
				g.desenhar_linha(410, 310, 380, 380) //perna esquerda
				g.desenhar_linha(410, 310, 440, 380) //perna direita
				g.definir_tamanho_texto(20.0)
				g.desenhar_texto(390, 175, "x") //x (olho) esquerdo
				g.desenhar_texto(420, 175, "x") //x (olho) direito
				g.definir_tamanho_texto(30.0)
				g.desenhar_texto(403, 185, "_") //boca
				g.definir_tamanho_texto(80.0)
				g.desenhar_texto(200, 400, "DERROTA!")
				g.definir_tamanho_texto(30.0)
				g.desenhar_texto(190, 470, "A palavra correta era " + palavraF + ".")
				g.definir_tamanho_texto(20.0)
			pare
		}
	}

	//função que exibe a tela de vitória
	funcao telaVitoria(){
		se(qtdAcertos >= tamanhoPF){
			inteiro corFundo2 = g.criar_cor(0, 250, 154)
			g.definir_cor(corFundo2)
			g.limpar()
			g.definir_cor(g.COR_PRETO)
			g.definir_tamanho_texto(80.0)
			g.desenhar_texto(200, 400, "VITÓRIA!")
			g.definir_tamanho_texto(30.0)
			g.desenhar_texto(300, 470, "Você venceu!")
			g.definir_tamanho_texto(200.0)
			g.desenhar_texto(300, 120, ":)")
		}
	
	}

	
	//função que verifica as letras pressionadas pelo jogador
	funcao verificarLetra(){
		inteiro cont1 = 0
		logico repetida = falso
		logico acerto = falso

		se (letraEnviada >= 'A' e letraEnviada <= 'Z') {
			continuar = verdadeiro
			se(tentativa1 == ' '){
				tentativa1 = letraEnviada
				qtdTentativas++
			} senao{
				se(tentativa1 == letraEnviada){
					repetida = verdadeiro
				}
				se(tentativa2 == ' ' e tentativa1 != ' '){
					tentativa2 = letraEnviada
					qtdTentativas++
				} senao{
					se(tentativa2 == letraEnviada){
						repetida = verdadeiro
					}
					se(tentativa3 == ' ' e tentativa1 != ' ' e tentativa1 != letraEnviada e tentativa2 != ' ' e tentativa2 != letraEnviada){
						tentativa3 = letraEnviada
						qtdTentativas++
					} senao{
						se(tentativa3 == letraEnviada){
							repetida = verdadeiro
						}
						se(tentativa4 == ' ' e tentativa1 != ' ' e tentativa1 != letraEnviada e tentativa2 != ' ' e tentativa2 != letraEnviada e tentativa3 != ' ' e tentativa3 != letraEnviada){
							tentativa4 = letraEnviada
							qtdTentativas++
						} senao{
							se(tentativa4 == letraEnviada){
								repetida = verdadeiro
							}
							se(tentativa5 == ' ' e tentativa1 != ' ' e tentativa1 != letraEnviada e tentativa2 != ' ' e tentativa2 != letraEnviada e tentativa3 != ' ' e tentativa3 != letraEnviada e tentativa4 != ' ' e tentativa4 != letraEnviada){
								tentativa5 = letraEnviada
								qtdTentativas++
							} senao{
								se(tentativa5 == letraEnviada){
									repetida = verdadeiro
								}
								se(tentativa6 == ' ' e tentativa1 != ' ' e tentativa1 != letraEnviada e tentativa2 != ' ' e tentativa2 != letraEnviada e tentativa3 != ' ' e tentativa3 != letraEnviada e tentativa4 != ' ' e tentativa4 != letraEnviada e tentativa5 != ' ' e tentativa5 != letraEnviada){
									tentativa6 = letraEnviada
									qtdTentativas++
								} senao{
									se(tentativa6 == letraEnviada){
										repetida = verdadeiro
									}
									se(tentativa7 == ' ' e tentativa1 != ' ' e tentativa1 != letraEnviada e tentativa2 != ' ' e tentativa2 != letraEnviada e tentativa3 != ' ' e tentativa3 != letraEnviada e tentativa4 != ' ' e tentativa4 != letraEnviada e tentativa5 != ' ' e tentativa5 != letraEnviada e tentativa6 != ' ' e tentativa6 != letraEnviada){
										tentativa7 = letraEnviada
										qtdTentativas++
									} senao{
										se(tentativa7 == letraEnviada){
											repetida = verdadeiro
										}
										se(tentativa8 == ' ' e tentativa1 != ' ' e tentativa1 != letraEnviada e tentativa2 != ' ' e tentativa2 != letraEnviada e tentativa3 != ' ' e tentativa3 != letraEnviada e tentativa4 != ' ' e tentativa4 != letraEnviada e tentativa5 != ' ' e tentativa5 != letraEnviada e tentativa6 != ' ' e tentativa6 != letraEnviada e tentativa7 != ' ' e tentativa7 != letraEnviada){
											tentativa8 = letraEnviada
											qtdTentativas++
										} senao{
											se(tentativa8 == letraEnviada){
												repetida = verdadeiro
											}
											se(tentativa9 == ' ' e tentativa1 != ' ' e tentativa1 != letraEnviada e tentativa2 != ' ' e tentativa2 != letraEnviada e tentativa3 != ' ' e tentativa3 != letraEnviada e tentativa4 != ' ' e tentativa4 != letraEnviada e tentativa5 != ' ' e tentativa5 != letraEnviada e tentativa6 != ' ' e tentativa6 != letraEnviada e tentativa7 != ' ' e tentativa7 != letraEnviada e tentativa8 != ' ' e tentativa8 != letraEnviada){
												tentativa9 = letraEnviada
												qtdTentativas++
											} senao{
												se(tentativa9 == letraEnviada){
													repetida = verdadeiro
												}
												se(tentativa10 == ' ' e tentativa1 != ' ' e tentativa1 != letraEnviada e tentativa2 != ' ' e tentativa2 != letraEnviada e tentativa3 != ' ' e tentativa3 != letraEnviada e tentativa4 != ' ' e tentativa4 != letraEnviada e tentativa5 != ' ' e tentativa6 != ' ' e tentativa6 != letraEnviada e tentativa7 != ' ' e tentativa8 != ' ' e tentativa8 != letraEnviada e tentativa9 != ' ' e tentativa9 != letraEnviada){
													tentativa10 = letraEnviada
													qtdTentativas++
												} senao{
													se(tentativa10 == letraEnviada){
														repetida = verdadeiro
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
		
			para (cont=0;cont<tamanhoPF;cont++) {
				se (separacao[cont] == letraEnviada e repetida == falso) {
					acerto = verdadeiro
					pJogador[cont] = letraEnviada
					
					se(qtdAcertos<=tamanhoPF){
						qtdAcertos++
					}
				} 	
			}
			se(continuar == verdadeiro e letraEnviada >= 'A' e letraEnviada <= 'Z'){
				se (acerto == falso e repetida == falso) {
					qtdErros++
				}								
			}	
	}
	
	//função que verifica o tempo decorrido de cada rodada
	funcao verificarTempo(){
		cadeia tempoF = ""
		inteiro tempoDecorrido = u.tempo_decorrido()
		inteiro tempo = 0
		
		se(tempoDecorrido < 10000){
			tempoF = tp.inteiro_para_cadeia(tempoDecorrido, 10)
			tempoF = txt.extrair_subtexto(tempoF, 0, 1)
		} senao {
			tempoF = tp.inteiro_para_cadeia(tempoDecorrido, 10)
			tempoF = txt.extrair_subtexto(tempoF, 0, 2)
		}

		se(tempoDecorrido > 100000){
			tempoF = tp.inteiro_para_cadeia(tempoDecorrido, 10)
			tempoF = txt.extrair_subtexto(tempoF, 0, 3)
		}

		tempo = tp.cadeia_para_inteiro(tempoF, 10)
		
		se(tempo > 120){
			inteiro corFundo2 = g.criar_cor(115, 3, 3)
			g.definir_cor(corFundo2)
			g.limpar()
			g.definir_cor(g.COR_PRETO)
			g.desenhar_linha(410, 100, 200, 100) // parte de cima da forca
			g.desenhar_linha(410, 100, 410, 150) //corda da forca
			g.desenhar_linha(200, 100, 200, 150) //esquerda da forca
			g.desenhar_elipse(370, 150, 80, 80, falso) //cabeça
			g.desenhar_linha(410, 230, 410, 310) //tronco
			g.desenhar_linha(410, 240, 380, 300) //braço esquerdo
			g.desenhar_linha(410, 240, 440, 300) //braço direito
			g.desenhar_linha(410, 310, 380, 380) //perna esquerda
			g.desenhar_linha(410, 310, 440, 380) //perna direita
			g.definir_tamanho_texto(20.0)
			g.desenhar_texto(390, 175, "x") //x (olho) esquerdo
			g.desenhar_texto(420, 175, "x") //x (olho) direito
			g.definir_tamanho_texto(30.0)
			g.desenhar_texto(403, 185, "_") //boca
			g.definir_tamanho_texto(80.0)
			g.desenhar_texto(200, 400, "DERROTA!")
			g.definir_tamanho_texto(30.0)
			g.desenhar_texto(300, 470, "Tempo esgotado.")
		}
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 6635; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */