<div id="top"></div>


<!-- PROJECT LOGO -->
<div align="center">
  <h2 align="center">TP1 : Analyse spectrale d’un signal</h2>
</div>

![logo](https://user-images.githubusercontent.com/80456274/151718182-54d53cc9-69bb-4710-af0e-f2fda10c0743.jpg)

<br />
<div align="center">
  <h3 align="center">Transformée de Fourier discrète</h3>
</div>


<!-- TABLE OF CONTENTS -->

  <summary>Table of Contents</summary>
  <ol>      
      <a href="#about-the-project">About The Project</a>         
      <li><a href="#Objectifs">Objectifs</a></li>
      <li><a href="#Représentation-temporelle-et-fréquentielle">Représentation temporelle et fréquentielle</a></li> 
      <li><a href="#Analyse-fréquentielle-du-chant-du-rorqual-bleu">Analyse fréquentielle du chant du rorqual bleu</a></li> 
      <li><a href="#Commandes-susceptibles-de-vous-être-utiles">Commandes susceptibles de vous être utiles</a></li> 
  </ol>



<!-- ABOUT THE PROJECT -->
# About The Project
This is an example of how you may give instructions on setting up your project locally.
To get a local copy up and running follow these simple example steps.

1. [**How to install Matlab**](https://csuf.screenstepslive.com/s/12867/m/48670/l/1263150-matlab-download-installation-for-windows-students)
2. **Clone the repo**
   ```sh
   git clone https://github.com/IlyasKadi/Rapport_TP1-Traitement-de-signal.git
   ```
 
<p align="right">(<a href="#top">back to top</a>)</p>


<!-- Overview -->
# Objectifs

> • Représentation de signaux et applications de la transformée de Fourier discrète
> (TFD) sous Matlab.
> • Evaluation de l’intérêt du passage du domaine temporel au domaine fréquentiel
> dans l’analyse et l’interprétation des signaux physiques réels.
> 
> **Commentaires** : Il est à remarquer que ce TP traite en principe des signaux continus.
> Or, l'utilisation de Matlab suppose l'échantillonnage du signal. Il faudra donc être
> vigilant par rapport aux différences de traitement entre le temps continu et le temps
> discret.
> 
> **Tracé des figures** : toutes les figures devront être tracées avec les axes et les
> légendes des axes appropriés.
> 
> **Travail demandé** : un script Matlab commenté contenant le travail réalisé et des
> commentaires sur ce que vous avez compris et pas compris, ou sur ce qui vous a
> semblé intéressant ou pas, bref tout commentaire pertinent sur le TP.

<p align="right">(<a href="#top">back to top</a>)</p>



# Représentation-temporelle-et-fréquentielle

Considérons un signal périodique x(t) constitué d’une somme de deux sinusoïdes de
fréquences 15Hz et 20Hz.
𝐱(𝐭) = 𝐬𝐢𝐧(𝟐𝝅𝟏𝟓𝒕) + 𝐬𝐢𝐧(𝟐𝝅𝟐𝟎𝒕)

1- Tracer le signal x(t). Pas de temps : Te = 1/50s, Intervalle : 0, 10-Te.
Pour approximer la TF continue d’un signal x(t), représenté suivant un pas Te, on
utilise les deux commandes : **fft et fftshif**.

```matlab
%--------------1------------------
Te=1/50;
x=[0:Te:10-Te];
y = sin(30*pi*x) + sin(40*pi*x);
subplot(3,2,1);
plot(x,y);
title('signal x(t) :');
```

![x(t)](https://user-images.githubusercontent.com/80456274/151722279-1a5ca9fb-f89c-4a23-952b-b61d0d3d7540.jpg)

▪ On remarquera que la TF est une fonction complexe et que la fonction ainsi
obtenue décrit la TF de x(t) entre –1/(2Te) et 1/(2Te) par pas de 1/(nTe) où n
est le nombre de points constituant le signal x(t).

▪ La commande fft codant les fréquences positives sur les n/2 premières valeurs
du signal et les valeurs négatives entre n/2+1 et n, la commande fftshift permet
de les inverser.

2- Calculer la TFD du signal x(t) en utilisant la commande fft, puis tracer son spectre
en amplitude après créer le vecteur f qui correspond à l'échantillonnage du signal dans
l'espace fréquentiel. Utilisez la commande abs.

```matlab
%--------------2------------------
f=(0:length(x)-1)*(1/Te*length(x)); 
fy=abs(fft(y));
subplot(3,2,2);
plot(f,fy);
title('spectre du  x(t) :');
```

![2_spectre_x(t)](https://user-images.githubusercontent.com/80456274/151722287-7b5bedff-18ca-4cd5-9189-48fedcea32d1.jpg)


3. Pour mieux visualiser le contenu fréquentiel du signal, utilisez la fonction fftshift,
qui effectue un décalage circulaire centré sur zéro du spectre en amplitude obtenu par
la commande fft.

```matlab
%--------------3------------------
fsh=[-500/2:(500/2)-1]*50/500;
fy=abs(fft(y));
subplot(3,2,3);
plot(fsh,fftshift(fy));
title('spectre du  x(t) :');
```

![3_spectre_x(t)_shifted](https://user-images.githubusercontent.com/80456274/151722292-dd00f316-e109-4625-ba08-e41e9b8757b1.jpg)


Un bruit correspond à tout phénomène perturbateur gênant la transmission ou
l'interprétation d'un signal. Dans les applications scientifiques, les signaux sont
souvent corrompus par du bruit aléatoire, modifiant ainsi leurs composantes
fréquentielles. La TFD peut traiter le bruit aléatoire et révéler les fréquences qui y
correspond.


4- Créez un nouveau signal xnoise, en introduisant un bruit blanc gaussien dans le
signal d’origine x(t), puis visualisez-le. Utiliser la commande **randn** pour générer ce
bruit. Il est à noter qu’un bruit blanc est une réalisation d'un processus aléatoire dans
lequel la densité spectrale de puissance est la même pour toutes les fréquences de
la bande passante. Ce bruit suit une loi normale de moyenne et variance données.

```matlab
%--------------4------------------
w_noise = randn(size(x));
subplot(3,2,4);
plot(w_noise);
title('noise');
```
La puissance du signal en fonction de la fréquence (densité spectrale de puissance)
est une métrique couramment utilisée en traitement du signal. Elle est définie comme
étant le carré du module de la TFD, divisée par le nombre d'échantillons de fréquence. 

5- Calculez puis tracer le spectre de puissance du signal bruité centré à la fréquence
zéro. Malgré le bruit, ont peut constater qu’il est toujours possible de distinguer les
fréquences du signal en raison des pics de puissance. En plus, on voit que, entre 0Hz
et 15Hz, la densité spectrale de puissance est relativement constante. Ceci est dû au
bruit blanc gaussien.

```matlab
%--------------5------------------
fy2 = abs(fft((y+w_noise))); 
DS=(fy2.^2)/length(x);
subplot(3,2,5);
plot(fsh,fftshift(DS));
title('x(t) noised');


fy2 = abs(fft((y+1.5*w_noise))); 
subplot(3,2,6);
plot(fsh,fftshift(fy2.^2));
title('x(t) noised (old noise*1.5)');
```

![4_x(t)_noised](https://user-images.githubusercontent.com/80456274/151722307-522dd9fb-1c15-4524-8fe2-91e2ce0f92f8.jpg)


![PART_I](https://user-images.githubusercontent.com/80456274/151722320-2d6f3561-7ef0-400b-8a70-0dff710407a0.jpg)


<p align="right">(<a href="#top">back to top</a>)</p>




# Analyse-fréquentielle-du-chant-du-rorqual-bleu

Il existe plusieurs signaux dont l’information est encodée dans des sinusoïdes. Les
ondes sonores est un bon exemple. Considérons maintenant des données audios
collectées à partir de microphones sous - marins au large de la Californie. On cherche
à détecter à travers une analyse de Fourier le contenu fréquentiel d’une onde sonore
émise pas un rorqual bleu.

1- Chargez, depuis le fichier **‘bluewhale.au’**, le sous-ensemble de données qui
correspond au chant du rorqual bleu du Pacifique. En effet, les appels de rorqual bleu
sont des sons à basse fréquence, ils sont à peine audibles pour les humains. Utiliser
la commande **audioread** pour lire le fichier. Le son à récupérer correspond aux indices
allant de 2.45e4 à 3.10e4.
```matlab
%--------------1------------------
whaleFile = fullfile(matlabroot,'examples','matlab','data','bluewhale.au');
[w,ft] = audioread(whaleFile);
interval=w(2.45e4:3.10e4);
```

2- Ecoutez ce signal en utilisant la commande **sound**, puis visualisez-le.
La TFD peut être utilisée pour identifier les composantes fréquentielles de ce signal
audio. Dans certaines applications qui traitent de grandes quantités de données avec
fft, il est courant de redimensionner l'entrée de sorte que le nombre d'échantillons soit
une puissance de 2. fft remplit automatiquement les données avec des zéros pour
augmenter la taille de l'échantillon. Cela peut accélérer considérablement le calcul de
la transformation.

```matlab
%--------------1------------------
soundsc(w,ft);
```


3- Spécifiez une nouvelle longueur de signal n qui sera une puissance de 2, puis tracer
la densité spectrale de puissance du signal.

```matlab
%--------------3------------------
fsh=[-500/2:(500/2)-1]*50/500;
fy=abs(fft(y));
subplot(3,2,3);
plot(fsh,fftshift(fy));
title('spectre du  x(t) :');
```




![PART_II](https://user-images.githubusercontent.com/80456274/151722498-90feadfd-cc76-4eda-86dd-c93019f5a3e3.jpg)


Code matlab

```matlab

clear all;
close all;
clc;

%--------------I------------------
figure(1);
%--------------1------------------
Te=1/50;
x=[0:Te:10-Te];
y = sin(30*pi*x) + sin(40*pi*x);
subplot(3,2,1);
plot(x,y);
title('signal x(t) :');


%--------------2------------------
f=(0:length(x)-1)*(1/Te*length(x)); 
fy=abs(fft(y));
subplot(3,2,2);
plot(f,fy);
title('spectre du  x(t) :');


%--------------3------------------
fsh=[-500/2:(500/2)-1]*50/500;
fy=abs(fft(y));
subplot(3,2,3);
plot(fsh,fftshift(fy));
title('spectre du  x(t) :');


%--------------4------------------
w_noise = randn(size(x));
subplot(3,2,4);
plot(w_noise);
title('noise');

%--------------5------------------
fy2 = abs(fft((y+w_noise))); 
DS=(fy2.^2)/length(x);
subplot(3,2,5);
plot(fsh,fftshift(DS));
title('x(t) noised');

fy2 = abs(fft((y+1.5*w_noise))); 
subplot(3,2,6);
plot(fsh,fftshift(fy2.^2));
title('x(t) noised (old noise*1.5)');




%--------------II------------------
figure(2);
%--------------1------------------
whaleFile = fullfile(matlabroot,'examples','matlab','data','bluewhale.au');
[w,ft] = audioread(whaleFile);
interval=w(2.45e4:3.10e4);

%--------------2------------------
soundsc(w,ft);

%--------------3------------------
subplot(2,1,1);
Nint=length(interval);
t=[0:Nint-1]*1/ft;
plot(t,interval);
title('Bluewhale signal');
%DS de la puissance du signal
fshift=[-Nint/2:Nint/2-1]*(ft/Nint)/10;
DSP=abs(fft(interval).^2/Nint);
subplot(2,1,2);
plot(fshift,fftshift(DSP));
title('DS de la puissance du signal')

```

<p align="right">(<a href="#top">back to top</a>)</p>





 
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Our Team     : [AIT EL KADI Ilyas](https://github.com/IlyasKadi) - [AZIZ Oussama](https://github.com/ATAMAN0)  
 
   Project Link : [Rapport_TP1 : Traitement-de-signal](https://github.com/IlyasKadi/Rapport_TP1-Traitement-de-signal)   
 
  > Encadré par  : [Pr. AMMOUR Alae]()  
                                                                                             
<p align="right">(<a href="#top">back to top</a>)</p>
