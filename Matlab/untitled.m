clear all;
files = ["name20", "name-20", "name40", "name-40", "name60", "name-60", "name80", "name-80", "name100", "name-100"];
voltages = [-100, -80, -60, -40, -20, 20, 40, 60, 80, 100];
k_all = [];
Tm_all = [];

figure(1);
hold on;

for i = 1:10
    data = readmatrix(files(i));
    U = voltages(i);
    time = data(:, 1);
    angle = data(:, 2) * pi / 180;
    
    idx = time <= 1;
    time_limited = time(idx);
    angle_limited = angle(idx);

    % Построение графика с указанием имени для легенды
    plot(time_limited, angle_limited, 'DisplayName', files(i));
    
    % Добавление штриховой линии для текущего значения угла
    yline(angle_limited(end), '--', 'HandleVisibility', 'off'); % Убираем из легенды
end

xlabel("time, s");
ylabel("angle, rad");

% Настройка легенды справа за пределами графика
legend('Location', 'eastoutside'); % Легенда справа за пределами графика

% Подбор цены деления для оси y
yticks(-20:5:20); % Задаем шаг 5 для оси y

hold off;