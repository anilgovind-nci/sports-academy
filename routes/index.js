var express = require('express');
var router = express.Router();

var express = require('express');
var router = express.Router();

function getAddressFromSession(req, res, next) {
  // Check if the address exists in the session
  if (req.session && req.session.address) {
      // Extract Ethereum address from session
      const address = req.session.address;
      // Make the address available to all route handlers
      res.locals.address = address;
  } else {
      // Set address to null or handle the error as per your requirement
      res.locals.address = null;
  }
  // Continue to the next middleware or route handler
  next();
}

/* Apply the middleware to all routes */
router.use(getAddressFromSession);

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('metamaskConncection', { title: 'Prime Sports Academy', name:null });
});

router.post('/login', function(req, res, next) {
  try {
      const { address } = req.body; // Assuming the address is sent in the request body
      if (!address) {
          return res.status(400).json({ error: 'Address not provided' });
      }
      console.log("received address:",address)
      req.session.address = address;
      return res.sendStatus(200); // Send a response to acknowledge the successful login
  } catch (error) {
      console.error(error);
      return res.status(500).json({ error: 'Internal Server Error' });
  }
});

router.get('/coin', function(req, res, next) {
  res.render('coin', { title: 'Prime Sports Academy', name:null, address: res.locals.address  });
});

router.get('/review', function(req, res, next) {
  res.render('review', { title: 'Prime Sports Academy', name:null, address: res.locals.address  });
});

router.get('/metamask', function(req, res, next) {
  res.render('metamaskConncection', { title: 'Prime Sports Academy', name:null  });
});

router.get('/student-review', function(req, res, next) {
  res.render('studentReview', { title: 'Prime Sports Academy', name:null  });
});

router.get('/sports-enroll', function(req, res, next) {
  res.render('sportsEnroll', { title: 'Prime Sports Academy', name:null  });
});

router.get('/students', function(req, res, next) {
  res.render('studentsView', { title: 'Prime Sports Academy', name:null  });
});

module.exports = router;
