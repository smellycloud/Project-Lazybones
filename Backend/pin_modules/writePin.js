var rpio = require('rpio');

module.exports = {
  writePin: function writePin(pin, state) {
    try {
      rpio.open(pin, rpio.OUTPUT, rpio.LOW);
      if (state === false) {
        rpio.write(pin, rpio.HIGH);
      } else {
        rpio.write(pin, rpio.LOW);
      }
    } catch (e) {
      console.error('GPIO write failed\n'+e);
    } finally {
      console.log('Write to pin',pin,'successful','\nSTATE_INPUT :',state);
    }
  }
};
