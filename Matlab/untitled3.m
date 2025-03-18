clear all;
clc;

% Загрузка данных
data = readmatrix('name100'); % Загружаем данные из файла
time = data(:, 1); % Время (первый столбец)
angle = data(:, 2) * pi / 180; % Угол (второй столбец, преобразуем в радианы)

% Ограничение времени до 1 секунды
idx = time <= 1;
time_limited = time(idx);
angle_limited = angle(idx);

% Начальные guess-параметры для аппроксимации
par0 = [15, 0.006]; % Начальные значения параметров [k, Tm]

% Функция для аппроксимации
U = 100; % Напряжение для файла name100
fun = @(par, time) U * par(1) * (time - par(2) * (1 - exp(-time / par(2)))); % Исправлено

% Оптимизация параметров
options = optimoptions('lsqcurvefit', 'Display', 'off'); % Отключаем вывод оптимизации
par_opt = lsqcurvefit(fun, par0, time_limited, angle_limited, [], [], options);

% Оптимизированные параметры
k_opt = par_opt(1); % Оптимизированное значение k
Tm_opt = par_opt(2); % Оптимизированное значение Tm

% Вывод оптимизированных параметров
fprintf('Оптимизированные параметры:\n');
fprintf('k = %.4f\n', k_opt);
fprintf('Tm = %.4f\n', Tm_opt);

% Построение графика угла от времени
figure;
plot(time_limited, angle_limited, 'b-', 'LineWidth', 1.5, 'DisplayName', 'Экспериментальные данные');
xlabel('Time, s');
ylabel('Angle, rad');
grid on;
hold on;

% Построение аппроксимирующей кривой с оптимизированными параметрами
angle_fit = fun(par_opt, time_limited);
plot(time_limited, angle_fit, 'r--', 'LineWidth', 1.5, 'DisplayName', 'Аппроксимирующая кривая');

% Настройка осей
xlim([0 1]); % Ограничение по оси X от 0 до 1
ylim([0 max(angle_limited) * 1.1]); % Ограничение по оси Y с небольшим запасом

% Добавление легенды
legend('Location', 'southeast');

% Улучшение внешнего вида графика
set(gca, 'FontSize', 12); % Увеличение размера шрифта осей
set(gca, 'Box', 'on'); % Включение рамки вокруг графика

hold off;