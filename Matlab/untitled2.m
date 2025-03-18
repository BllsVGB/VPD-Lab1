clear all;
files = ["name20", "name-20", "name40", "name-40", "name60", "name-60", "name80", "name-80", "name100", "name-100"];
voltages = [-100, -80, -60, -40, -20, 20, 40, 60, 80, 100];

figure(1);
hold on;

for i = 1:10
    data = readmatrix(files(i));
    U = voltages(i);
    time = data(:, 1);
    omega = data(:, 3) * pi / 180; % Угловая скорость в радианах/секунду

    idx = time <= 1;
    time_limited = time(idx);
    omega_limited = omega(idx);
    
    % Построение графика с указанием имени для легенды
    plot(time_limited, omega_limited, 'DisplayName', files(i));
end

xlabel("time, s");
ylabel("ang speed, rad/s");

% Настройка легенды справа за пределами графика
legend('Location', 'eastoutside'); % Легенда справа за пределами графика

% Подбор цены деления для оси y
yticks(-30:5:30); % Задаем шаг 5 для оси y

hold off;