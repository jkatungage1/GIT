const express = require('express');  //npm install express
const path = require('path');
const cors = require('cors');        //npm install cors

const app = express();
const port = 3000;

// Pour faire autoriser le "Cross-Origin Resource Sharing (CORS)" d'un client spécifique 
app.use(cors({
  origin: 'http://localhost:8080'
}));

// Chemin vers le fichier JSON de apple
const apple = path.join(__dirname, './Data/AAPL-rates-5y.json');

// Route pour servir le fichier json de Apple
app.get('/AAPL-rates-5y.json', (req, res) => {
  console.log("Fichier AAPL envoyé !")
  res.sendFile(apple);
});

/**
 * 
 * Rajout d'une route pour servir le fichier json de Facebook
 * 
 */

/**
 * 
 * Rajout d'une route pour servir le fichier json de Google
 * 
 */

/**
 * 
 * Rajout d'une route pour servir le fichier json de Microsoft
 * 
 */


// Démarrage du serveur !!
/**
 * 
 * app.listen ...
 * 
 */

