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
    angle = data(:, 2) * pi / 180; % Угол (второй столбец, преобразуем в радианы)

    % Ограничение времени до 1 секунды
    idx = time <= 1;
    time_limited = time(idx);
    angle_limited = angle(idx);

    % Создание нового графика
    figure;
    plot(time_limited, angle_limited, 'b-', 'LineWidth', 1.5);
    xlabel('time, s');
    ylabel('angle, rad');
    title(sprintf('График зависимости угла от времени для файла %s', files(i)));
    grid on;

    % Настройка осей
    xlim([0 1]); % Ограничение по оси X от 0 до 1
    ylim([min(angle_limited) * 1.1, max(angle_limited) * 1.1]); % Ограничение по оси Y с небольшим запасом

    % Улучшение внешнего вида графика
    set(gca, 'FontSize', 12); % Увеличение размера шрифта осей
    set(gca, 'Box', 'on'); % Включение рамки вокруг графика
end