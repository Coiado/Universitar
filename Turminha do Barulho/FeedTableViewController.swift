//
//  FeedTableViewController.swift
//  FeedTest
//
//  Created by Henrique de Abreu Amitay on 23/10/15.
//  Copyright © 2015 Henrique de Abreu Amitay. All rights reserved.
//

import UIKit
import Parse

class FeedTableViewController: UITableViewController, UISearchControllerDelegate, UISearchBarDelegate, CustomSearchControllerDelegate {
    
    //TEMP
    let LOREM = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. "
    let jornalismo = "Uma aura de glamour acompanha o trabalho de correspondente de guerra desde que o primeiro jornalista foi enviado a um campo de batalha para relatar seus horrores. Na guerra da Criméia, em 1854, William Howard Russel, do jornal The Times, mandava seus despachos via telégrafo. Um século e meio depois, as notícias se propagam em tempo real. E mesmo quem não é jornalista profissional pode ser convertido em porta-voz de informações.\n\nTrabalhar em zonas conflagradas para mostrar ao mundo as atrocidades de um conflito armado é encarado como o lado mais romântico da profissão, mas o cotidiano daqueles que estão no front é bem diferente. O correspondente de guerra ganha fama e visibilidade, no entanto, a rotina é dura e os perigos, constantes. O Observatório da Imprensa exibido ao vivo pela TV Brasil na terça-feira (13/09) discutiu o encanto que esta atividade exerce no cidadão comum e entre os jovens jornalistas.\n\nAlberto Dines recebeu três jornalistas com larga experiência em cobertura de conflitos. Em São Paulo, o Observatório contou com a presença de Leão Serva e Samy Adghirni. Professor e escritor, Serva foi correspondente na Bósnia, Angola, Somália e Kuait. Trabalhou na Folha de S.Paulo, criou o site Último Segundo e foi o responsável pela recente mudança editorial do jornal Diário de S. Paulo. Adghirni é repórter da editoria Mundo da Folha de S.Paulo. Especialista em assuntos de Oriente Médio e política externa, passou parte deste ano cobrindo a Primavera Árabe. Esteve no Egito, na Tunísia e na Líbia. Já esteve no Irã, Iraque, Iêmen, Israel e outros países. No Rio de Janeiro, o convidado foi Antonio Scorza, fotógrafo da Agência France Presse há vinte e cinco anos. Scorza cobriu inúmeras rebeliões, eleições, posses presidenciais na América Latina, entre outros eventos.\n\nEm editorial, Dines avaliou que a grande quantidade de conflitos bélicos e a facilidade para cobri-los levou à ilusão de que “o correspondente de guerra é o único que na redação tem oportunidade para viver grandes aventuras e bravuras”. Para ele, a defesa da sociedade contra o narcotráfico pode exigir mais bravura do que o campo de batalha. “Pouco adianta mostrar ao público tanques em chamas, guerreiros correndo com armas na mão, metralhadoras pipocando, jatos em voos rasantes, feridos pedindo ajuda, mães chorando. O leitor, ouvinte ou telespectador, antes de tudo, quer saber por que os homens estão se matando em vez de sentar para negociar. Cobrir guerras não é o lado mais empolgante do jornalismo. Explicar contenciosos e, sobretudo, não alimentar rancores é missão muito mais heroica. E só jornalistas podem desempenhá-la”, sublinhou o jornalista."
    let economia = "Você sabe quanto vale o dólar? No início de março a moeda rompeu pela primeira vez em 10 anos a barreira dos R$ 3. A cotação da moeda muda a cada dia, mas essa variação não é importante apenas para os economistas. Isso porque, o preço do dólar também pode interferir no seu dia a dia.\n\nA tendência, segundo analistas, é que a moeda dos EUA permaneça num patamar mais elevado diante do cenário político e econômico conturbado e das incertezas sobre o ajuste fiscal das contas públicas brasileiras. Mas, apesar de ter subido também em relação a outras moedas, por causa de uma expectativa de aumento dos juros da economia americana, é na comparação com o real que o dólar apresenta uma de suas maiores altas.\n\nEm menos de três meses, a cotação do dólar vendido no Brasil passou de R$2,69 para R$ 3,19, uma diferença de R$ 0,50. Esse é um fenômeno que vem sendo verificado desde setembro de 2014, quando a cotação estava abaixo de R$ 2,3. Pode parecer pouco, mas qualquer valorização do câmbio causa um enorme impacto na economia, porque afeta o preço de produtos importados, encarece as viagens ao exterior, interfere em contratos firmados em dólar e, por fim, pressiona a inflação. Entenda, abaixo, como funciona a cotação do dólar."
    let computacao = "Nos próximos anos, as carreiras mais valorizadas estarão ligadas às engenharia e tecnologia, uma vez que a demanda do mercado ainda é muito alta e a quantidade de profissionais, na atualidade, ainda não supre essa necessidade. Portanto, aqueles que estão em busca de rápido acesso ao mercado de trabalho e ganhos significativos precisam manter a atenção nas tendências do mercado.\n\nO estudante, em alguns casos, ainda não tem a preparação necessária para escolher uma profissão, pois muitas das vezes tem menos de 20 anos quando isso ocorre e até, muito depois disso, ainda falta maturidade para definir qual a melhor carreira a ser seguida.\n\nDependendo da situação, é bem comum encontrar pessoas frustradas depois da faculdade, uma vez que a escolha parece saturada e com isso os salários são extremamente baixos e a inserção no mercado é mais demorada. Dessa maneira, na hora da escolha é melhor levar em consideração as habilidades naturais, bem como o rumo das carreiras mais atrativas, em diversos aspectos."
    let mecatronica = "O futuro das indústrias será marcado pela integração entre humanos e robôs. A previsão é da Arup, empresa de engenharia de projetos, sediada na Inglaterra.\nA previsão foi publicada em um relatório internacional chamado “Repensando a fábrica”. “A inevitável mudança para formas mais enxutas, inteligentes e flexíveis de produção terá uma série de impactos sobre a forma como fábricas são projetadas”, escreve a Arup.\nA empresa sugere que os humanos não serão substituídos por robôs (como alguns preveem), mas que os dois trabalharão juntos. Essa integração seria a marca da quarta revolução industrial – que estamos experimentando atualmente.\nUma das principais características dessa revolução seria com o uso de tecnologias ciberfísicas. O papel dos humanos seria menos de lidar com tarefas manuais e mais de supervisionar cadeias de produção e de analisar dados."
    let gastronomia = "Pizzaiolos amadores do mundo, uni-vos: a arte de fazer pizzas agora conta com curso de extensão universitária no Reino Unido./nA Manchester Metropolitan University criou o curso sobre o assunto em parceria com uma rede de pizzarias. No currículo, voltado para quem deseja entrar no ramo da Gastronomia e de Hospitalidade, estão desde aulas sobre as receitas e métodos de preparo até noções básicas de finanças e administração./nA intenção é formar 1.500 aprendizes nos próximos cinco anos. De acordo com porta-vozes da universidade, o propósito do curso é formar pessoas para trabalhar não só na rede de fast food que patrocina o curso, mas também para quem deseja montar o próprio restaurante no futuro."
    let vestibular = "A Universidade Estadual de Campinas (Unicamp) abre nesta segunda-feira (3), às 9h, o período de inscrições para o vestibular 2016. Os candidatos devem preeencher o formulário até 3 de setembro, exclusivamente pelo site da comissão responsável por organizar a prova (Comvest). A taxa é de R$ 150 e a instituição tem 3.320 vagas em 70 cursos de graduação.\nO exame da primeira fase será aplicado em 22 de novembro, enquanto que as avaliações da segunda etapa serão realizadas em 17, 18 e 19 de janeiro de 2016. Segundo a Comvest, as provas de habilidades específicas para os candidados aos cursos de música irão ocorrer de 24 a 28 de setembro. Já os inscritos para as carreiras de arquitetura e urbanismo, artes cências, artes visuais e dança devem fazer os exames específicos de 25 a 28 de janeiro.\nA Unicamp manterá nesta edição o modelo de provas aplicado no vestibular 2015. Na primeira fase, os candidatos terão 90 questões de múltipla escolha nas disciplinas de língua portuguesa e literaturas de língua portuguesa, matemática, história, geografia, sociologia, filosofia, física, química, biologia e inglês, além de perguntas interdisciplinares."
    
    //Outlets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet var segControl: UISegmentedControl!
    @IBOutlet weak var nightmodeButton: UIBarButtonItem!
    
    //Search controllers
    var customSearchController: CustomSearchController!
    var shouldShowSearchResults = false
    
    //Volume de dados
    var data : [Dados] = []
    var dadosFiltrados = [Dados]()
    var chosenCell: Dados?
    
    //Array de celulas, usamos para poder acessar toda as celulas de uma vez so
    var cellArray : [FeedCell] = []
    var nightMode : Bool!
    
    //QUANDO QUISER ALTERAR UMA COR ALTERE AQUI =)
    //Colors
    let bgColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)  //Cor de fundo
    
    let detailsColor = UIColor(red: 255/255, green: 209/255, blue: 0/255, alpha: 1) //Cor dos detalhes (fonte, icones, etc)
    
    let tableBG = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1) //Cor do fundo apenas da tableview
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createData()
        
        self.configRefresh()
        
        self.tableView.reloadData()
        
        self.nightMode = false
        
        self.refreshColors()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }
    
    //Funcao que usaremos para eventualmente implementar metodo de leitura noturna, talvez
    //nao precisemos mais
    @IBAction func setNightMode(sender: AnyObject) {
    
     self.nightMode = !self.nightMode
        
     print(self.nightMode)
    
     self.tableView.reloadData()

    }
    
    //Esta funcao seta todas as cores da view, é usada como redundancia ao storyboard para que tenhamos
    //total controle sobre elas
    func refreshColors()
    {
       
        //Set the colors of the view
        self.view.backgroundColor = bgColor;
        self.tableView.separatorColor = detailsColor
        
        //Set the color of the navigation view background
        self.navigationController?.navigationBar.barTintColor = bgColor
        self.segmentedControl.backgroundColor = bgColor
        self.segmentedControl.tintColor = detailsColor
        
        //Change Status Bar Color
        self.setNeedsStatusBarAppearanceUpdate()
        //UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        
        //Configure the custom search controller
        configureCustomSearchController()
        
        //TableView Background
        self.tableView.backgroundView = nil
        self.tableView.backgroundColor = tableBG
       

    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clearColor()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if self.shouldShowSearchResults{
            return dadosFiltrados.count
        }
        
        else{
            return data.count
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("FeedCard", forIndexPath: indexPath) as! FeedCell
        
        let info: Dados
        
        if self.shouldShowSearchResults{
        
            info = dadosFiltrados[indexPath.row] as Dados
            
        }
        else{
        
            if self.segmentedControl.selectedSegmentIndex == 0{
                
                info = data[indexPath.row] as Dados
                
            }
        
            else{
                
                let arrayCurtido: [Dados] = data.sort{$0.upvote > $1.upvote}
                info = arrayCurtido[indexPath.row] as Dados
                
                
            }
        }
        cell.upvoteCount.text = "\(String(info.upvote!))"
        cell.title.text = info.titulo
        cell.subTitle.text = info.subtitulo!
        cell.textField.text = info.texto
        cell.picture.image = info.imagem
        cell.fullText = info.fulltext
        
        
        cell.cardSetup()
        
        
        //self.refreshColors()
        if(self.nightMode == true)
        {
            cell.setColors()
        }
        
        return cell
    }
    
    //Este tamanho de celula é hardcoded, pois a priori todas as celulas tem o mesmo tamanho, deve ser mudado
    //caso precisemos colocar um tamanho dinamico nas celulas
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 94
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.GoToDetail(indexPath.row)
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.4
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        
        //        let secondViewController = segue.destinationViewController as! FeedDetailsViewController
        //
        //        let cell = self.chosenCell
        //
        //        secondViewController.receiveCellData(cell!);
       
        if segue.identifier == "detalhesNoticia" {
            if let destination = segue.destinationViewController as? FeedDetailsViewController {
                let path = self.tableView?.indexPathForSelectedRow!
                let cell = self.tableView!.cellForRowAtIndexPath(path!) as! FeedCell
                destination.passedCell = cell
            }
        }
    }
    
    //Essa funcao cria dados hardcoded para que possamos testar o layout da tableview
    func createData()
    {
        self.data.append(Dados(titulo: "Jornal na guerra", subtitulo: "Jornalismo", texto: "Saiba mais sobre os jornalistas que cobriram de perto algumas guerras", imagem: UIImage(named: "Jtest"),upvote: 5,fulltext:jornalismo))
        
        self.data.append(Dados(titulo: "Alta do dolar", subtitulo: "Economia", texto: "Dólar subiu? Bolsa quebrou? Saiba como um economista influencia essa área", imagem: UIImage(named: "Etest"), upvote: 12,fulltext:economia))
        
        self.data.append(Dados(titulo: "Mercado em Alta", subtitulo: "Computação", texto: "Busca por profissionais na área de TI aumenta 78%", imagem: UIImage(named: "Ctest"),upvote: 69,fulltext:computacao))
        
         self.data.append(Dados(titulo: "Revolução", subtitulo: "Engenharia", texto: "Robôs estão revolucionando a indústria atual, dando destaque para carreiras na área de Mecatrônica", imagem: UIImage(named: "Mtest"),upvote: 24,fulltext:mecatronica))
       
          self.data.append(Dados(titulo: "Profissão Pizzaiolo", subtitulo: "Gastronomia", texto: "Universidade britânica oferece curso especializado em pizzas", imagem: UIImage(named: "Gtest"),upvote: 30,fulltext:gastronomia))
        
        self.data.append(Dados(titulo: "Comvest 2016", subtitulo: "Vestibular", texto: "Inscrições para o vestibular da Comvest começam segunda-feira"
            , imagem: UIImage(named: "Vtest"),upvote: 100,fulltext:vestibular))
        
        self.tableView.reloadData()
    }
    
    
    //MARK - Metodos para o refresh
    
    func configRefresh(){
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.backgroundColor = bgColor
        self.refreshControl!.tintColor = detailsColor
        self.refreshControl!.addTarget(self, action: "refreshTableView:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(self.refreshControl!)
        
    }
    
    func refreshTableView(sender: AnyObject){
        
        print("refresh")
        self.tableView.reloadData()
        self.refreshControl!.endRefreshing()
        
    }
    
    // MARK:- Metodos para upvoted
    
     func GoToDetail(sender: Int) {
       
        if self.shouldShowSearchResults{
            self.chosenCell = dadosFiltrados[sender] as Dados
            
        }
        else{
            
            if self.segmentedControl.selectedSegmentIndex == 0{
                self.chosenCell = data[sender] as Dados
            }
                
                else{
                let arrayCurtido: [Dados] = data.sort{$0.upvote > $1.upvote}
                self.chosenCell = arrayCurtido[sender] as Dados
            }
        }
        performSegueWithIdentifier("detalhesNoticia", sender: self)
    }
    
    //MARK: - SearchController
    
    func configureCustomSearchController() {
        customSearchController = CustomSearchController(searchResultsController: self, searchBarFrame: CGRectMake(0.0, 0.0, self.tableView.frame.size.width, 50.0), searchBarFont: UIFont(name: "Futura", size: 16.0)!, searchBarTextColor: detailsColor, searchBarTintColor: bgColor)
        
        customSearchController.searchBar.searchBarStyle = UISearchBarStyle.Default
        customSearchController.customSearchBar.placeholder = "Procure"
        self.tableView.tableHeaderView = customSearchController.customSearchBar
        
        customSearchController.customDelegate = self
        
    }
    
    func didStartSearching() {
        shouldShowSearchResults = true
        self.tableView.reloadData()
    }
    
    func didTapOnSearchButton() {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            self.tableView.reloadData()
        }
    }
    
    func didTapOnCancelButton() {
        shouldShowSearchResults = false
        self.tableView.reloadData()
    }
    
    func didChangeSearchText(searchText: String) {
        // Filter the data array and get only those countries that match the search text.
        self.dadosFiltrados = self.data.filter({ (Dados) -> Bool in
            let stringMatch: NSString = Dados.titulo!
            
            return (stringMatch.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch).location) != NSNotFound
        })
        // Reload the tableview.
        self.tableView.reloadData()
    }
    
    //MARK:- Metodos do segmented control
    @IBAction func segmentedControlTapped(sender: AnyObject) {
        self.tableView.reloadData()
    }
    
}



