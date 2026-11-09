#!/bin/bash
echo "Generando el nuevo index.html con imágenes reales..."
cat > index.html << 'HTML'
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Biblioteca de Cuentos</title>
<style>
  body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #fdf6ec; margin: 0; padding: 20px; color: #333; }
  h1 { text-align: center; color: #8b5a2b; font-size: 2.5em; margin-bottom: 40px; }
  .menu { display: flex; flex-wrap: wrap; justify-content: center; gap: 30px; max-width: 1000px; margin: 0 auto; }
  .card { background: #fff; border-radius: 15px; box-shadow: 0 8px 16px rgba(0,0,0,0.1); cursor: pointer; overflow: hidden; width: 280px; text-align: center; transition: transform 0.3s; }
  .card:hover { transform: translateY(-10px); }
  .card-img { height: 180px; background-size: cover; background-position: center; background-color: #eee; }
  .card-title { padding: 15px; font-size: 1.4em; font-weight: bold; color: #8b5a2b; }
  
  .viewer { display: none; max-width: 1100px; margin: 0 auto; background: #fff; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.15); padding: 20px; }
  .viewer.active { display: block; }
  .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; border-bottom: 2px solid #eee; padding-bottom: 10px; }
  .btn { padding: 12px 25px; font-size: 1.1em; border: none; border-radius: 10px; cursor: pointer; font-weight: bold; transition: 0.2s; }
  .btn-back { background: #f4d0b5; color: #8b5a2b; }
  .btn-audio { background: #69aee6; color: white; }
  .btn-next { background: #8fbf6b; color: white; font-size: 1.3em; padding: 15px 40px; }
  .btn:hover { opacity: 0.8; }
  
  .page { display: flex; flex-direction: row; gap: 30px; align-items: center; min-height: 400px; }
  @media (max-width: 768px) { .page { flex-direction: column; } .text-content { font-size: 1.2em !important; } }
  
  .img-content { flex: 1; display: flex; justify-content: center; align-items: center; border-radius: 15px; overflow: hidden; min-height: 250px; max-height: 500px; }
  .img-content img { width: 100%; height: auto; max-height: 500px; object-fit: contain; }
  
  .text-content { flex: 1; font-size: 1.5em; line-height: 1.6; color: #444; text-align: justify; }
  .controls { display: flex; justify-content: space-between; margin-top: 20px; }
</style>
</head>
<body>

<h1 id="main-title">Biblioteca de Cuentos</h1>
<div id="menu" class="menu">
  <div class="card" onclick="openBook('cerditos')">
    <div class="card-img" style="background-image: url('cerditos/cerditos-1.png');"></div>
    <div class="card-title">Los 3 Cerditos</div>
  </div>
  <div class="card" onclick="openBook('caperucita')">
    <div class="card-img" style="background-image: url('caperucita/caperucita-1.png');"></div>
    <div class="card-title">Caperucita Roja</div>
  </div>
  <div class="card" onclick="openBook('patito')">
    <div class="card-img" style="background-image: url('patito/patito-1.png');"></div>
    <div class="card-title">El Patito Feo</div>
  </div>
</div>

<div id="viewer" class="viewer">
  <div class="header">
    <button class="btn btn-back" onclick="closeBook()">⬅ Menú</button>
    <h2 id="book-title" style="margin:0; color:#8b5a2b;">Título</h2>
    <button class="btn btn-audio" onclick="speakText()">🔊 Escuchar</button>
  </div>
  <div class="page">
    <div class="img-content"><img id="page-img" src="" alt="Ilustración"></div>
    <div class="text-content" id="page-text">Texto de prueba...</div>
  </div>
  <div class="controls">
    <button class="btn btn-back" onclick="prevPage()">⬅ Anterior</button>
    <button class="btn btn-next" onclick="nextPage()">Siguiente ➡</button>
  </div>
</div>

<script>
const books = {
  cerditos: {
    title: "Los 3 Cerditos", folder: "cerditos",
    pages: [
      "Al lado de sus padres, tres cerditos habían crecido alegres en una cabaña del bosque. Y como ya eran mayores, sus papás decidieron que era hora de que construyeran, cada uno, su propia casa.",
      "El primer cerdito, el perezoso de la familia, decidió hacer una casa de paja. En un minuto la choza estaba ya hecha. Y entonces se fue a dormir.",
      "El segundo cerdito, un glotón, prefirió hacer la cabaña de madera. No tardó mucho en construirla. Y luego se fue a comer manzanas.",
      "El tercer cerdito, muy trabajador, optó por construirse una casa de ladrillos y cemento. Tardaría más en construirla pero estaría más protegido.",
      "El lobo se acercó a la casa de paja. – ¡Ábreme la puerta! ¡Ábreme la puerta o soplaré y tu casa tiraré!. Como el cerdito no la abrió, el lobo sopló con fuerza, y derrumbó la casa de paja.",
      "El cerdito corrió a la casa de madera. El lobo sopló y sopló, y aunque la casita de madera aguantó mucho más que la de paja, al final la casita se fue por los aires.",
      "Los dos cerditos corrieron a la casa de ladrillos. El lobo sopló con todas sus fuerzas, pero la casa ni se movió. ¡Era muy fuerte!",
      "El lobo decidió bajar por la chimenea. Pero los cerditos pusieron un caldero con agua hirviendo. El lobo se quemó y salió corriendo, nunca más volvió.",
      "Así los cerditos pudieron vivir tranquilos y aprendieron que solo con el trabajo se consiguen las cosas. ¡Fin!"
    ]
  },
  caperucita: {
    title: "Caperucita Roja", folder: "caperucita",
    pages: [
      "Había una vez una adorable niña que siempre usaba un gorrito rojo, por eso todos la llamaban Caperucita Roja.",
      "Un día su madre le dijo: —Lleva este pastel y esta botella de vino a tu abuelita que está enferma. No te apartes del camino.",
      "En el bosque se encontró con un lobo. El lobo le preguntó a dónde iba. Caperucita le dijo que a casa de su abuelita, que vivía bajo tres grandes robles.",
      "El lobo le dijo: —Mira las flores, ¿por qué no recoges algunas? Caperucita se distrajo cortando flores y se adentró en el bosque.",
      "Mientras tanto, el lobo corrió a la casa de la abuelita. Tocó la puerta, entró y se comió a la abuelita de un bocado. Luego se puso su ropa y se metió en la cama.",
      "Caperucita llegó. —¡Abuelita, qué ojos tan grandes tienes! —Son para verte mejor. —¡Qué boca tan grande tienes! —Es para comerte mejor. Y el lobo se la tragó.",
      "Un cazador pasó por allí, escuchó los ronquidos y entró. Abrió la panza del lobo con tijeras y salvó a Caperucita y a la abuelita.",
      "Llenaron la panza del lobo con piedras. Cuando despertó, quiso correr pero pesaba tanto que cayó. Caperucita prometió no volver a salirse del camino. ¡Fin!"
    ]
  },
  patito: {
    title: "El Patito Feo", folder: "patito",
    pages: [
      "En el campo, mamá pata esperaba a que nacieran sus patitos. Uno de los huevos tardó mucho en abrirse. Cuando nació, la pata vio lo grande y feo que era.",
      "Los otros patitos y las gallinas se burlaban de él por ser diferente. —¡Qué feo es! —decían. Incluso sus hermanos lo trataban mal.",
      "El patito huyó del corral. Llegó a unos pantanos y pasó la noche triste. —Es porque soy tan feo —pensó. Vio perros y cazadores, pero por suerte no lo comieron.",
      "Llegó el invierno, hacía mucho frío y el patito tuvo que nadar sin parar para no congelarse. Un campesino lo rescató del hielo y lo llevó a su casa.",
      "Los niños de la casa querían jugar con él, pero el patito se asustó y volcó la leche. La mujer se enojó y él escapó a la nieve.",
      "Por fin llegó la primavera. El patito movió sus alas y voló hasta un estanque. Allí vio tres hermosos cisnes blancos.",
      "El patito se acercó, y al mirarse en el agua, vio su reflejo: ¡ya no era un patito feo, era un hermoso cisne blanco! Los otros cisnes lo acogieron.",
      "Unos niños dijeron: —¡Hay un cisne nuevo, es el más hermoso! Él era muy feliz, pues comprendió que la verdadera belleza está en el corazón. ¡Fin!"
    ]
  }
};

let currentBook = null;
let currentPage = 0;

function openBook(id) {
  currentBook = books[id];
  currentPage = 0;
  document.getElementById('menu').style.display = 'none';
  document.getElementById('main-title').style.display = 'none';
  document.getElementById('viewer').classList.add('active');
  renderPage();
}

function closeBook() {
  document.getElementById('viewer').classList.remove('active');
  document.getElementById('menu').style.display = 'flex';
  document.getElementById('main-title').style.display = 'block';
  window.speechSynthesis.cancel();
}

function renderPage() {
  window.speechSynthesis.cancel();
  document.getElementById('book-title').innerText = currentBook.title;
  
  // Aquí se arma la ruta de la imagen: ej. "caperucita/caperucita-1.png"
  document.getElementById('page-img').src = currentBook.folder + "/" + currentBook.folder + "-" + (currentPage + 1) + ".png";
  
  document.getElementById('page-text').innerText = currentBook.pages[currentPage];
}

function nextPage() {
  if (currentPage < currentBook.pages.length - 1) {
    currentPage++;
    renderPage();
  }
}

function prevPage() {
  if (currentPage > 0) {
    currentPage--;
    renderPage();
  }
}

function speakText() {
  window.speechSynthesis.cancel();
  const text = currentBook.pages[currentPage];
  const utterance = new SpeechSynthesisUtterance(text);
  utterance.lang = 'es-ES';
  utterance.rate = 0.9;
  window.speechSynthesis.speak(utterance);
}
</script>
</body>
</html>
HTML
echo "Haciendo commit y push a GitHub..."
git add index.html
git commit -m "Cambio a imagenes reales y estructura de carpetas"
git push origin main
echo "¡Listo! Sube las imagenes a las carpetas correspondientes en GitHub."
