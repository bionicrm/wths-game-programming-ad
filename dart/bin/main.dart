import 'dart:html';
import 'dart:math';

const short = false;

void main() {
  CanvasElement canvas = querySelector('#canvas');

  var ctx = canvas.context2D,
      width = canvas.width = window.innerWidth,
      height = canvas.height = window.innerHeight,
      stopwatch = new Stopwatch()..start();

  var rand = new Random();
  var go = new GameObject(position: new Vector(width / 2, height / 2), speed: 0, direction: 0);
  go.radius = 50;

  var player = new GameObject(position: new Vector(-100, height / 3), speed: 0, direction: 0);
  var thrust = new Vector(0, 0);
  var angle = 0;
  var turningLeft = false;
  var turningRight = false;
  var thrusting = false;
  var firing = false;
  var audioI = 0;

  List<AudioElement> audios = new List.generate(50, (i) {
    return new AudioElement('sound/bubble.wav');
  });

  List<GameObject> bullets = new List();
  List<GameObject> particles;
  List<GameObject> miniParts = new List();

  document.body.addEventListener('keydown', (KeyEvent e) {
    switch (e.keyCode) {
      case KeyCode.UP:
        thrusting = true;
        break;
      case KeyCode.LEFT:
        turningLeft = true;
        break;
      case KeyCode.RIGHT:
        turningRight = true;
        break;
      case KeyCode.SPACE:
        firing = true;
        break;
    }
  });

  document.body.addEventListener('keyup', (KeyEvent e) {
    switch (e.keyCode) {
      case KeyCode.UP:
        thrusting = false;
        break;
      case KeyCode.LEFT:
        turningLeft = false;
        break;
      case KeyCode.RIGHT:
        turningRight = false;
        break;
    }
  });

  void render() {
    var elapsed = stopwatch.elapsedMilliseconds;

    ctx.clearRect(0, 0, width, height);

    if (elapsed <= (short ? 1000 : 4000)) {
      ctx.beginPath();
      ctx.arc(go.position.x, go.position.y, go.radius, 0, PI * 2);
      ctx.fill();
    }
    else if (elapsed <= (short ? 2000 : 9000)) {
      go.velocity.y += 0.2;

      if (go.position.y + go.velocity.y + go.radius > height) {
        go.velocity.y = -go.velocity.y * 0.99;
      }

      go.updatePosition();

      ctx.beginPath();
      ctx.arc(go.position.x, go.position.y, 50, 0, PI * 2);
      ctx.fill();
    }
    else if (elapsed <= (short ? 3000 : 14000)) {
      go.velocity.y += 0.2;

      if (go.position.y + go.velocity.y + go.radius > height) {
        go.velocity.y = -go.velocity.y * 0.99;
      }

      go.updatePosition();

      ctx.beginPath();
      ctx.arc(go.position.x, go.position.y, go.radius, 0, PI * 2);
      ctx.fill();

      if (particles == null) {
        particles = new List.generate(50, (i) {
          var o = new GameObject(position: go.position.copy(), speed: rand.nextDouble() * 20 + 5, direction: rand.nextDouble() * PI + PI);
          o.radius = rand.nextInt(20) + 10;
          return o;
        });
      }

      List<GameObject> toRemove = new List();

      particles.forEach((e) {
        e.velocity.y += 0.5;

        if (e.position.y + e.velocity.y - e.radius > height) {
          toRemove.add(e);
        }
        else {
          e.updatePosition();

          ctx.beginPath();
          ctx.arc(e.position.x, e.position.y, e.radius, 0, PI * 2);
          ctx.fill();
        }
      });

      toRemove.forEach((e) {
        particles.remove(e);

        var o = new GameObject(position: go.position.copy(), speed: rand.nextDouble() * 20 + 5, direction: rand.nextDouble() * PI + PI);
        o.radius = rand.nextInt(20) + 10;
        particles.add(o);
      });
    }
    else if (elapsed <= (short ? 4000 : 17000)) {
      go.velocity.y += 0.2;

      if (go.position.y + go.velocity.y + go.radius > height) {
        go.velocity.y = -go.velocity.y * 0.99;
      }

      go.updatePosition();

      List<GameObject> toRemove = new List();

      particles.forEach((e) {
        e.velocity.y += 0.5;

        if (e.position.y + e.velocity.y - e.radius > height) {
          toRemove.add(e);
        }
        else {
          e.updatePosition();

          ctx.beginPath();
          ctx.setFillColorRgb(e.r, e.g, e.b);
          ctx.arc(e.position.x, e.position.y, e.radius, 0, PI * 2);
          ctx.fill();
        }
      });

      toRemove.forEach((e) {
        particles.remove(e);

        var o = new GameObject(position: go.position.copy(), speed: rand.nextDouble() * 20 + 5, direction: rand.nextDouble() * PI + PI);
        o.radius = rand.nextInt(20) + 10;
        o.r = rand.nextInt(255);
        o.g = rand.nextInt(255);
        o.b = rand.nextInt(255);
        particles.add(o);
      });

      ctx.beginPath();
      ctx.setFillColorRgb(0, 0, 0);
      ctx.arc(go.position.x, go.position.y, go.radius, 0, PI * 2);
      ctx.fill();
    }
    else if (elapsed <= (short ? 999999999999 : 30000)) {
      go.velocity.y += 0.2;

      if (go.position.y + go.velocity.y + go.radius > height) {
        go.velocity.y = -go.velocity.y * 0.99;
      }

      go.updatePosition();

      List<GameObject> toRemove = new List();

      particles.forEach((e) {
        e.velocity.y += 0.5;

        if (e.position.y + e.velocity.y - e.radius > height) {
          toRemove.add(e);
        }
        else {
          e.updatePosition();

          ctx.beginPath();
          ctx.setFillColorRgb(e.r, e.g, e.b);
          ctx.arc(e.position.x, e.position.y, e.radius, 0, PI * 2);
          ctx.fill();
        }
      });

      toRemove.forEach((e) {
        particles.remove(e);

        if (particles.length < 10) {
          var o = new GameObject(position: go.position.copy(), speed: rand.nextDouble() * 20 + 5, direction: rand.nextDouble() * PI + PI);
          o.radius = rand.nextInt(20) + 20;
          o.r = rand.nextInt(255);
          o.g = rand.nextInt(255);
          o.b = rand.nextInt(255);
          particles.add(o);
        }
      });

      ctx.beginPath();
      ctx.setFillColorRgb(0, 0, 0);
      ctx.arc(go.position.x, go.position.y, go.radius, 0, PI * 2);
      ctx.fill();

      if (turningRight) {
        angle += 0.05;
      }

      if (turningLeft) {
        angle -= 0.05;
      }

      if (thrusting) {
        thrust.setLength(0.175);
      }
      else {
        thrust.setLength(0);
      }

      thrust.setAngle(angle);
      player.velocity += thrust;

      var mockPlayerPos = player.copy().updatePosition().position;

      if (mockPlayerPos.x - 100 > width) {
        player.position.x = 0;
      }

      if (mockPlayerPos.x + 100 < 0) {
        player.position.x = width;
      }

      if (mockPlayerPos.y - 100 > height) {
        player.position.y = 0;
      }

      if (mockPlayerPos.y + 100 < 0) {
        player.position.y = height;
      }

      player.updatePosition();

      ctx.lineWidth = 10;

      if (firing) {
        var pP = player.position.copy();
        var o = new GameObject(position: pP, direction: angle, speed: 15);
        bullets.add(o);
        firing = false;
      }

      List<GameObject> toRemoveBullets = new List();

      bullets.forEach((e) {
        e.updatePosition();

        ctx.save();
        ctx.translate(e.position.x + cos(e._direction) * 100, e.position.y - 2.5 + sin(e._direction) * 100);

        ctx.beginPath();
        ctx.setStrokeColorRgb(33, 101, 196);
        ctx.moveTo(0, 0);
        ctx.lineTo(cos(e._direction) * 100, sin(e._direction) * 100);
        ctx.stroke();

        ctx.restore();

        if (e.position.x - 100 > width || e.position.x + 100 < 0 || e.position.y - 100 > height || e.position.y + 100 < 0) {
          toRemoveBullets.add(e);
        }
      });

      ctx.save();
      ctx.translate(player.position.x, player.position.y);
      ctx.rotate(angle);

      if (thrusting) {
        ctx.beginPath();
        ctx.setStrokeColorRgb(207, 57, 25);
        ctx.moveTo(0, 0);
        ctx.lineTo(-60, 0);
        ctx.stroke();
      }

      ctx.beginPath();
      ctx.setStrokeColorRgb(0, 0, 0);
      ctx.moveTo(0, -50);
      ctx.lineTo(100, 0);
      ctx.moveTo(100, 0);
      ctx.lineTo(0, 50);
      ctx.moveTo(0, 50);
      ctx.lineTo(0, -50);
      ctx.stroke();

      ctx.restore();

      bullets.forEach((e) {
        particles.forEach((p) {
          if (e.position.copy().setLength(e.position.getLength() + 50).distanceTo(p.position) <= 50 + p.radius) {
            if (++audioI >= audios.length) {
              audioI = 0;
            }

            audios[audioI].play();
            toRemoveBullets.add(e);
            toRemove.add(p);
          }
        });
      });

      toRemoveBullets.forEach((e) {
        bullets.remove(e);
      });

      toRemove.forEach((e) {
        for (int i = 0; i < 10; i++) {
          var o = new GameObject(position: e.position.copy(), speed: rand.nextDouble() * 20 + 5, direction: rand.nextDouble() * PI * 2);
          o.r = 120;
          o.g = 120;
          o.b = 120;
          o.radius = rand.nextInt(15) + 5;
          miniParts.add(o);
        }

        particles.remove(e);

        if (particles.length < 10) {
          var o = new GameObject(position: go.position.copy(), speed: rand.nextDouble() * 20 + 5, direction: rand.nextDouble() * PI + PI);
          o.radius = rand.nextInt(20) + 20;
          o.r = rand.nextInt(255);
          o.g = rand.nextInt(255);
          o.b = rand.nextInt(255);
          particles.add(o);
        }
      });

      List<GameObject> miniPartsToRemove = new List();

      miniParts.forEach((e) {
        e.velocity.y += 0.5;

        if (e.position.y + e.velocity.y - e.radius > height) {
          miniPartsToRemove.add(e);
        }
        else {
          e.updatePosition();

          ctx.beginPath();
          ctx.setFillColorRgb(e.r, e.g, e.b);
          ctx.arc(e.position.x, e.position.y, e.radius, 0, PI * 2);
          ctx.fill();
        }
      });

      miniPartsToRemove.forEach((e) {
        miniParts.remove(e);
      });
    }

    // request animation frame
    window.animationFrame.then((value) {
      render();
    });
  }

  render();
}

class Vector {
  num x;
  num y;

  Vector(this.x, this.y);

  Vector.zero() : this(0, 0);

  double getLength() {
    return sqrt(getLengthSquared());
  }

  num getLengthSquared() {
    return pow(x, 2) + pow(y, 2);
  }

  num distanceTo(Vector v)
  {
    return sqrt(distanceSquaredTo(v));
  }

  num distanceSquaredTo(Vector v)
  {
    var dx = x - v.x,
        dy = y - v.y;
    return dx * dx + dy * dy;
  }

  double getAngle() {
    return atan2(y, x);
  }

  Vector setLength(num length) {
    return setAngleAndLength(angle: getAngle(), length: length);
  }

  Vector setAngle(num angle) {
    return setAngleAndLength(angle: angle, length: getLength());
  }

  Vector setAngleAndLength({num angle, num length}) {
    x = cos(angle) * length;
    y = sin(angle) * length;
    return this;
  }

  Vector add(Vector v) {
    x += v.x;
    y += v.y;
    return this;
  }

  Vector sub(Vector v) {
    x -= v.x;
    y -= v.y;
    return this;
  }

  Vector mulScalar(num scalar) {
    x *= scalar;
    y *= scalar;
    return this;
  }

  Vector divScalar(num scalar) {
    x /= scalar;
    y /= scalar;
    return this;
  }

  Vector operator +(Vector v) {
    return new Vector(x + v.x, y + v.y);
  }

  Vector operator -(Vector v) {
    return new Vector(x - v.x, y - v.y);
  }

  Vector operator *(num n) {
    return new Vector(x * n, y * n);
  }

  Vector copy() {
    return new Vector(x, y);
  }
}

class GameObject {
  Vector position;
  Vector velocity;
  num radius;
  num r, g, b;

  num _direction;
  num _speed;

  GameObject({this.position, num direction, num speed}) {
    this._direction = direction;
    this._speed = speed;;
    velocity = new Vector.zero().setAngleAndLength(angle: direction, length: speed);
  }

  GameObject updatePosition() {
    position.add(velocity);
    return this;
  }

  GameObject copy() {
    return new GameObject(position: position, direction: _direction, speed: _speed);
  }
}
