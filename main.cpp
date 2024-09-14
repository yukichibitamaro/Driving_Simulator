
#include <SFML/Graphics.hpp>

class Car {
public:
    Car() {
        shape.setSize(sf::Vector2f(50, 300));
        shape.setFillColor(sf::Color::Black);
        shape.setPosition(375, 270);
        velocity = 0.1f;
    }

    void update() {
        if (sf::Keyboard::isKeyPressed(sf::Keyboard::Up)) {
            shape.move(0, -velocity);
        }
        if (sf::Keyboard::isKeyPressed(sf::Keyboard::Down)) {
            shape.move(0, velocity);
        }
        if (sf::Keyboard::isKeyPressed(sf::Keyboard::Left)) {
            shape.move(-velocity, 0);
        }
        if (sf::Keyboard::isKeyPressed(sf::Keyboard::Right)) {
            shape.move(velocity, 0);
        }
    }

    void draw(sf::RenderWindow& window) {
        window.draw(shape);
    }

private:
    sf::RectangleShape shape;
    float velocity;
};

int main() {
    sf::RenderWindow window(sf::VideoMode(800, 600), "Simple 2D Car Simulator");
    Car car;

    while (window.isOpen()) {
        sf::Event event;
        while (window.pollEvent(event)) {
            if (event.type == sf::Event::Closed) {
                window.close();
            }
        }

        car.update();

        window.clear(sf::Color::White); // Windowの背景色の設定

        car.draw(window);

        window.display();
    }

    return 0;
}
