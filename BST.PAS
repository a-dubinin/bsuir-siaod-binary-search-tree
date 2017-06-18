{Изучение бинарного дерева.
Разработчик - Дубинин А. В.}
program BST;

{Подключение модуля Crt}
uses crt;

{Объявление констант}
const
    ROOT_X = 40; {Координата X для построения корня дерева}
    ROOT_Y = 5;  {Координата Y для построения корня дерева}
    SPACES = 2;  {Количество отступов}
    DATA_NUM = 12;
    DATA_ARR: array[1..DATA_NUM] of integer = (100,20,120,50,15,130,55,30,35,60,33,28);

{Объявление типов}
type
    Tree = ^Node;
    Node = record
        data: integer;
        left, right, parent: Tree;
    end;

{Процедура перевода строки}
procedure br;
    begin
        writeln;
    end;

{Процедура вывода на всю ширину окна горизонтальной полосы}
procedure hr;
    var
        i: integer;
    begin
        for i := 1 to 79 do write('-');
        br;
    end;

{Процедура вывода на экран массива исходных данных}
procedure displayElements;
    var
        i: integer;
    begin
        for i := 1 to DATA_NUM do
            begin
                write(DATA_ARR[i]);
                if i <> DATA_NUM then
                    write(', ');
            end;
        br;
        hr;
    end;

{Процедура создания корня бинарного дерева.
node - параметр-переменная типа Tree,
data - параметр-константа тип integer}
procedure setRoot(var node: Tree; const data: integer);
    begin
        new(node);
        node^.data := data;
        node^.left := nil;
        node^.right := nil;
        node^.parent := nil;
    end;

{Процедура создания потомка у родителя.
parent - параметр-константа типа Tree,
child - параметр-переменная типа Tree,
data - параметр-константа тип integer}
procedure setChild(const parent: Tree; var child: Tree; const data: integer);
    begin
        new(child);
        child^.data := data;
        child^.left := nil;
        child^.right := nil;
        child^.parent := parent;
    end;

{Процедура построения бинарного дерева.
bst - параметр-переменная типа Tree}
procedure buildBST(var bst: Tree);
    var
        i, data: integer;
        node: Tree;
        isSet: boolean;
    begin

        {Построение бинарного дерева на основе массива исходных данных}
        for i := 1 to DATA_NUM do
            begin
                data := DATA_ARR[i];
                {Создание корня дерева}
                if i = 1 then
                    setRoot(bst, data)
                {Создание узлов дерева}
                else
                    begin
                        node := bst;
                        isSet := false;
                        repeat
                            if data < node^.data then
                                begin
                                    if node^.left = nil then
                                        begin
                                            {Создание левого потомка}
                                            setChild(node, node^.left, data);
                                            isSet := true;
                                        end
                                    else
                                        node := node^.left;
                                end
                            else if data > node^.data then
                                begin
                                    if node^.right = nil then
                                        begin
                                            {Создание правого потомка}
                                            setChild(node, node^.right, data);
                                            isSet := true;
                                        end
                                    else
                                        node := node^.right;
                                end;
                        until isSet = true;
                    end;
            end;
    end;

{Процедура вывода на экран с помощью отступов бинарного дерева.
bst - параметр-константа типа Tree,
x, y, s - параметры-константы типа integer}
procedure displayBST(const bst: Tree; const x, y, s: integer);
    begin
        if bst <> nil then
            begin
                if bst^.parent^.left = bst then
                    begin
                        gotoXY(x + s, y - 1);
                        write('/');
                    end
                else if bst^.parent^.right = bst then
                    begin
                        gotoXY(x - s + 1, y - 1);
                        write('\');
                    end;
                gotoXY(x, y);
                write(bst^.data);
                displayBST(bst^.left, x - 2 * s, y + 2, s);
                displayBST(bst^.right, x + 2 * s, y + 2, s);
            end;
    end;

{Процедура прямого обхода бинарного дерева (сверху-вниз).
bst - параметр-константа типа Tree}
procedure traversePrefix(const bst: Tree);
    begin
        if bst <> nil then
            begin
                write(bst^.data, ', ');
                traversePrefix(bst^.left);
                traversePrefix(bst^.right);
            end;
    end;

{Процедура внутреннего обхода бинарного дерева (слева-направо).
bst - параметр-константа типа Tree}
procedure traverseInfix(const bst: Tree);
    begin
        if bst <> nil then
            begin
                traverseInfix(bst^.left);
                write(bst^.data, ', ');
                traverseInfix(bst^.right);
            end;
    end;

{Процедура обратного обхода бинарного дерева (снизу-вверх).
bst - параметр-константа типа Tree}
procedure traversePostfix(var bst: Tree);
    begin
        if bst <> nil then
            begin
                traversePostfix(bst^.left);
                traversePostfix(bst^.right);
                write(bst^.data, ', ');
            end;
    end;

{Функция, реализующая симметричноправая прошивка бинарного дерева.
Выводит на экран узлы с прошивочными нитями.
bst - параметр-константа типа Tree}
function doSymmetricallyRight(const bst: Tree): Tree;
    var
        node: Tree;
    begin
        if bst <> nil then
            begin
                node := doSymmetricallyRight(bst^.left);
                if node <> nil then
                    begin
                        node^.right := bst;
                        writeln(node^.data, ' ---', chr(26), ' ', bst^.data);
                    end;
                if bst^.right <> nil then
                    doSymmetricallyRight := doSymmetricallyRight(bst^.right)
                else
                    doSymmetricallyRight := bst;
            end
        else
            doSymmetricallyRight := nil;
    end;

{Процедура исполнения программы}
procedure runApplication;
    var
        bst: Tree;
        h: integer;
    begin
        clrscr;
        br;
        write('Записи дерева: ');
        displayElements;

        buildBST(bst);
        displayBST(bst, ROOT_X, ROOT_Y, SPACES);

        for h := 1 to ROOT_Y + DATA_NUM do br;

        hr;
        writeln('Прямой обход дерева (сверху-вниз): ');
        br;
        traversePrefix(bst);
        br;

        hr;
        writeln('Внутренний обход дерева (слева-направо): ');
        br;
        traverseInfix(bst);
        br;

        hr;
        writeln('Обратный обход дерева (снизу-вверх): ');
        br;
        traversePostfix(bst);
        br;

        hr;
        writeln('Прошивочные нити (симметричноправая прошивка дерева): ');
        br;
        doSymmetricallyRight(bst);

        readkey;
    end;

begin
    runApplication;
end.