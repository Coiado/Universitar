//
//  PrivacidadeViewController.swift
//  Turminha do Barulho
//
//  Created by Lucas Coiado Mota on 1/27/16.
//  Copyright © 2016 Lucas Coiado Mota. All rights reserved.
//

import UIKit

class PrivacidadeViewController: UIViewController {


    @IBOutlet var privacidadeText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        privacidadeText.text = "Ao utilizar e participar de forma ativa no Univesitar, de qualquer das formas que o Aplicativo permite, o Utilizador declara ter lido e aceitar cumprir os presentes Termos E Condições. O Univesitar reserva-se o direito – mas não a obrigação – de, perante o não cumprimento destes Termos e Condições, eliminar todo e qualquer conteúdo que os infrinja, bem como restringir e/ou bloquear o acesso do Utilizador infractor à participação no Aplicativo, sem qualquer aviso prévio.\n\nNa utilização que fizer deste Aplicativo (incluindo na submissão, envio ou publicação de conteúdos que fizer para o Univesitar), o Utilizador está obrigado e declara aceitar e cumprir a legislação aplicável, e concretamente o Código do Direito de Autor e dos Direitos Conexos, o Código da Propriedade Industrial e a Lei da Criminalidade Informática.\n\nO Utilizador está também obrigado a e declara agir de boa-fé e a fazer uma utilização do Univesitar que não ofenda quaisquer direitos de terceiros. Particularmente, compromete-se a não submeter qualquer conteúdo ou fazer uma participação que constitua qualquer ataque em função da raça, nacionalidade, origem étnica, religião, convicção política ou sexo; que constitua difamação, incitação ao furto, fraude, violência, terrorismo, sadismo, prostituição, pedofilia, bem como que empregue conteúdos de carácter obsceno, indecoroso ou pornográfico.\n\nO Utilizador apenas está autorizado a fazer uso dos conteúdos presentes no Univesitar para fins estritamente pessoais, sendo-lhe expressamente proibido publicar, reproduzir, difundir, distribuir ou, por qualquer outra forma, tornar os conteúdos acessíveis a terceiros, para fins de comunicação pública ou de comercialização, como por exemplo colocando-os disponíveis noutro App, serviço on-line ou em cópias de papel. Está igualmente vedada qualquer transformação dos conteúdos.\n\nÉ também expressamente proibido ao Utilizador criar ou introduzir no Univesitar tipos de vírus ou programas que o danifiquem, directa ou indirectamente.\n\nO Univesitar, e o respectivo conteúdo, tem finalidade exclusivamente informativa, pelo que nada neste Aplicativo constitui um conselho profissional, nem estabelece qualquer relação contratual.\n\nO Univesitar não é responsável por qualquer eventual perda ou danos, directos ou indirectos, sofridos por qualquer utilizador relativamente à informação contida neste App.\n\nO Utilizador é o único responsável pelos prejuízos, directos ou indirectos, causados a si próprio, ao Univesitar ou a terceiros, relacionados com a utilização que fizer do Univesitar, comprometendo-se a proceder às indemnizações necessárias, em virtude de qualquer acção, reclamação ou condenação a que essa utilização dê origem.\n\nO Univesitar não garante que os serviços prestados por este Aplicativo funcionem de forma contínua ou que se encontrem livres de erros, vírus ou outros elementos prejudiciais.\n\nO Univesitar não é responsável pela exactidão, qualidade, segurança, legalidade ou licitude, incluindo o cumprimento das regras respeitantes a direitos de autor e direitos conexos, relativamente aos conteúdos, produtos ou serviços contidos neste Aplicativo que tenham sido criados ou fornecidos por membros, utilizadores, anunciantes ou parceiros comerciais, bem como por qualquer informação contida em Apps de terceiros para os quais este Aplicativo estabeleça ligações.\n\nO Utilizador declara autorizar, a título gratuito, a divulgação, publicação, utilização e exploração dos conteúdos, textos, dados, imagens ou programas por si enviados para o Univesitar.\n\nO Utilizador declara igualmente que:tem plena legitimidade para autorizar a utilização previamente mencionada e, concretamente, que obteve e dispõe dos necessários direitos e autorizações a título de direitos de autor e assegurou os pagamentos eventualmente devidos a terceiros legítimos titulares de direitos sobre os conteúdos, textos, dados, imagens ou programas por si enviados para o Univesitar, para efeitos da sua utilização nos termos previstos na presente declaração; sobre o direito de autorizar a utilização dos conteúdos, textos, dados, imagens ou programas por si enviados para o Univesitar constantes da presente declaração, não existe qualquer reclamação ou processo instaurado ou alguma contestação relativamente à sua titularidade por parte de terceiros; não existe nenhum compromisso nem nenhuma condição decorrente de relações jurídicas eventualmente existentes entre o Utilizador e terceiros que impeça ou condicione, de algum modo, a execução total ou parcial da presente declaração nos termos nela definidos. O Univesitar exime-se de qualquer responsabilidade resultante da falta de veracidade do anteriormente declarado ou da violação pelo Utilizador de quaisquer direitos ou interesses legitimamente protegidos de terceiros. O Univesitar reserva-se no direito de livremente (sem obrigatoriedade de invocar qualquer motivo) e em qualquer momento, remover ou não publicar, total ou parcialmente, quaisquer conteúdos, textos, dados, imagens, aplicações ou programas, editados por si ou pelo Utilizador, sem que por tal facto advenha qualquer direito de indemnização ou compensação para o Utilizador ou quaisquer terceiros.\n\n\n\nNão existe qualquer obrigação do Univesitar em guardar os conteúdos, textos, dados, imagens ou programas publicados neste Aplicativo, podendo os mesmos ser destruídos a qualquer momento, sem que por tal facto advenha qualquer direito de indemnização para o Utilizador ou quaisquer terceiros."
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func recusarButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
