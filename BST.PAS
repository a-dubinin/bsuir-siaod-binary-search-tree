{���祭�� ����୮�� ��ॢ�.
���ࠡ��稪 - �㡨��� �. �.}
program BST;

{������祭�� ����� Crt}
uses crt;

{������� ����⠭�}
const
    ROOT_X = 40; {���न��� X ��� ����஥��� ���� ��ॢ�}
    ROOT_Y = 5;  {���न��� Y ��� ����஥��� ���� ��ॢ�}
    SPACES = 2;  {������⢮ ����㯮�}
    DATA_NUM = 12;
    DATA_ARR: array[1..DATA_NUM] of integer = (100,20,120,50,15,130,55,30,35,60,33,28);

{������� ⨯��}
type
    Tree = ^Node;
    Node = record
        data: integer;
        left, right, parent: Tree;
    end;

{��楤�� ��ॢ��� ��ப�}
procedure br;
    begin
        writeln;
    end;

{��楤�� �뢮�� �� ��� �ਭ� ���� ��ਧ��⠫쭮� ������}
procedure hr;
    var
        i: integer;
    begin
        for i := 1 to 79 do write('-');
        br;
    end;

{��楤�� �뢮�� �� ��࠭ ���ᨢ� ��室��� ������}
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

{��楤�� ᮧ����� ���� ����୮�� ��ॢ�.
node - ��ࠬ���-��६����� ⨯� Tree,
data - ��ࠬ���-����⠭� ⨯ integer}
procedure setRoot(var node: Tree; const data: integer);
    begin
        new(node);
        node^.data := data;
        node^.left := nil;
        node^.right := nil;
        node^.parent := nil;
    end;

{��楤�� ᮧ����� ��⮬�� � த�⥫�.
parent - ��ࠬ���-����⠭� ⨯� Tree,
child - ��ࠬ���-��६����� ⨯� Tree,
data - ��ࠬ���-����⠭� ⨯ integer}
procedure setChild(const parent: Tree; var child: Tree; const data: integer);
    begin
        new(child);
        child^.data := data;
        child^.left := nil;
        child^.right := nil;
        child^.parent := parent;
    end;

{��楤�� ����஥��� ����୮�� ��ॢ�.
bst - ��ࠬ���-��६����� ⨯� Tree}
procedure buildBST(var bst: Tree);
    var
        i, data: integer;
        node: Tree;
        isSet: boolean;
    begin

        {����஥��� ����୮�� ��ॢ� �� �᭮�� ���ᨢ� ��室��� ������}
        for i := 1 to DATA_NUM do
            begin
                data := DATA_ARR[i];
                {�������� ���� ��ॢ�}
                if i = 1 then
                    setRoot(bst, data)
                {�������� 㧫�� ��ॢ�}
                else
                    begin
                        node := bst;
                        isSet := false;
                        repeat
                            if data < node^.data then
                                begin
                                    if node^.left = nil then
                                        begin
                                            {�������� ������ ��⮬��}
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
                                            {�������� �ࠢ��� ��⮬��}
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

{��楤�� �뢮�� �� ��࠭ � ������� ����㯮� ����୮�� ��ॢ�.
bst - ��ࠬ���-����⠭� ⨯� Tree,
x, y, s - ��ࠬ����-����⠭�� ⨯� integer}
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

{��楤�� ��אַ�� ��室� ����୮�� ��ॢ� (ᢥ���-����).
bst - ��ࠬ���-����⠭� ⨯� Tree}
procedure traversePrefix(const bst: Tree);
    begin
        if bst <> nil then
            begin
                write(bst^.data, ', ');
                traversePrefix(bst^.left);
                traversePrefix(bst^.right);
            end;
    end;

{��楤�� ����७���� ��室� ����୮�� ��ॢ� (᫥��-���ࠢ�).
bst - ��ࠬ���-����⠭� ⨯� Tree}
procedure traverseInfix(const bst: Tree);
    begin
        if bst <> nil then
            begin
                traverseInfix(bst^.left);
                write(bst^.data, ', ');
                traverseInfix(bst^.right);
            end;
    end;

{��楤�� ���⭮�� ��室� ����୮�� ��ॢ� (᭨��-�����).
bst - ��ࠬ���-����⠭� ⨯� Tree}
procedure traversePostfix(var bst: Tree);
    begin
        if bst <> nil then
            begin
                traversePostfix(bst^.left);
                traversePostfix(bst^.right);
                write(bst^.data, ', ');
            end;
    end;

{�㭪��, ॠ������� ᨬ����筮�ࠢ�� ��訢�� ����୮�� ��ॢ�.
�뢮��� �� ��࠭ 㧫� � ��訢��묨 ���ﬨ.
bst - ��ࠬ���-����⠭� ⨯� Tree}
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

{��楤�� �ᯮ������ �ணࠬ��}
procedure runApplication;
    var
        bst: Tree;
        h: integer;
    begin
        clrscr;
        br;
        write('����� ��ॢ�: ');
        displayElements;

        buildBST(bst);
        displayBST(bst, ROOT_X, ROOT_Y, SPACES);

        for h := 1 to ROOT_Y + DATA_NUM do br;

        hr;
        writeln('��אַ� ��室 ��ॢ� (ᢥ���-����): ');
        br;
        traversePrefix(bst);
        br;

        hr;
        writeln('����७��� ��室 ��ॢ� (᫥��-���ࠢ�): ');
        br;
        traverseInfix(bst);
        br;

        hr;
        writeln('����� ��室 ��ॢ� (᭨��-�����): ');
        br;
        traversePostfix(bst);
        br;

        hr;
        writeln('��訢��� ��� (ᨬ����筮�ࠢ�� ��訢�� ��ॢ�): ');
        br;
        doSymmetricallyRight(bst);

        readkey;
    end;

begin
    runApplication;
end.