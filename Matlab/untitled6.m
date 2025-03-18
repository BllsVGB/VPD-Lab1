clear all;
clc;

% Список файлов
files = ["name20", "name-20", "name40", "name-40", "name60", "name-60", "name80", "name-80", "name100", "name-100"];
voltages = [-100, -80, -60, -40, -20, 20, 40, 60, 80, 100];

% Цикл по каждому файлу
for i = 1:length(files)
    % Загрузка данных
    data = readmatrix(files(i)); % Загружаем данные из файла
    time = data(:, 1); % Время (первый столбец)
    omega = data(:, 3) * pi / 180; % Угловая скорость (третий столбец, преобразуем в радианы/с)

    % Ограничение времени до 1 секунды
    idx = time <= 1;
    time_limited = time(idx);
    omega_limited = omega(idx);

    % Создание нового графика
    figure;
    plot(time_limited, omega_limited, 'b-', 'LineWidth', 1.5);
    xlabel('time, s');
    ylabel('ang speed, rad/s');
    title(sprintf('График зависимости угловой скорости от времени для файла %s', files(i)));
    grid on;

    % Настройка осей
    xlim([0 1]); % Ограничение по оси X от 0 до 1
    ylim([min(omega_limited) * 1.1, max(omega_limited) * 1.1]); % Ограничение по оси Y с небольшим запасом

    % Улучшение внешнего вида графика
    set(gca, 'FontSize', 12); % Увеличение размера шрифта осей
    set(gca, 'Box', 'on'); % Включение рамки вокруг графика
end