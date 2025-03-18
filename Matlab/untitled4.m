clear all;
clc;

% Загрузка данных
data = readmatrix('name100'); % Загружаем данные из файла
time = data(:, 1); % Время (первый столбец)
omega = data(:, 3) * pi / 180; % Угловая скорость (третий столбец, преобразуем в радианы/с)

% Ограничение времени до 1 секунды
idx = time <= 1;
time_limited = time(idx);
omega_limited = omega(idx);

% Начальные guess-параметры для аппроксимации
par0 = [15, 0.006]; % Начальные значения параметров [k, Tm]

% Функция для аппроксимации угловой скорости
U = 100; % Напряжение для файла name100
fun = @(par, time) U * par(1) * (1 - exp(-time / par(2))); % Аппроксимирующая функция для угловой скорости

% Оптимизация параметров
options = optimoptions('lsqcurvefit', 'Display', 'off'); % Отключаем вывод оптимизации
par_opt = lsqcurvefit(fun, par0, time_limited, omega_limited, [], [], options);

% Оптимизированные параметры
k_opt = par_opt(1); % Оптимизированное значение k
Tm_opt = par_opt(2); % Оптимизированное значение Tm

% Вывод оптимизированных параметров
fprintf('Оптимизированные параметры:\n');
fprintf('k = %.4f\n', k_opt);
fprintf('Tm = %.4f\n', Tm_opt);

% Построение графика угловой скорости от времени
figure;
plot(time_limited, omega_limited, 'b-', 'LineWidth', 1.5, 'DisplayName', 'Экспериментальные данные');
xlabel('time, s');
ylabel('ang speed, rad/s');
grid on;
hold on;

% Построение аппроксимирующей кривой с оптимизированными параметрами
omega_fit = fun(par_opt, time_limited);
plot(time_limited, omega_fit, 'r--', 'LineWidth', 1.5, 'DisplayName', 'Аппроксимирующая кривая');

% Настройка осей
xlim([0 1]); % Ограничение по оси X от 0 до 1
ylim([0 max(omega_limited) * 1.1]); % Ограничение по оси Y с небольшим запасом

% Добавление легенды
legend('Location', 'southeast');

% Улучшение внешнего вида графика
set(gca, 'FontSize', 12); % Увеличение размера шрифта осей
set(gca, 'Box', 'on'); % Включение рамки вокруг графика

hold off;