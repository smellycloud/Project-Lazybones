var rpio = require('rpio');

module.exports = {
  readPin: function readPin(pin) {
    //rpio.open(pin, rpio.INPUT);
    if(rpio.read(pin) === 1)
      return false;
    else
      return true;
  }
};
