Program Client;

{
  Program to test Sockets unit by Michael van Canneyt and Peter Vreman
  Client Version, First Run sock_svr to let it create a socket and then
  sock_cli to connect to that socket
}

uses Sockets,Sysutils;

procedure PError(const S : string);
begin
  writeln(S,SocketError);
  halt(100);
end;


Var
  SAddr    : TInetSockAddr;
  Buffer   : string [255];
  S        : Longint;
  Sin,Sout : Text;
  i        : integer;
  f        : TextFile;

begin
  Assign(f, 'teste');
  S:=fpSocket (AF_INET,SOCK_STREAM,0);
  if s=-1 then
   Perror('Client : Socket : ');
  SAddr.sin_family:=AF_INET;
  { port 50000 in network order }
  SAddr.sin_port:=htons(5000);
  { localhost : 127.0.0.1 in network order }
  SAddr.sin_addr.s_addr:=HostToNet((127 shl 24) or 1);
  if not Connect (S,SAddr,Sin,Sout) then
   PError('Client : Connect : ');
  ReWrite(Sout);
  Reset(f);
  while not eof(f) do
    begin
      readln(f, Buffer);
      Writeln(Sout, Buffer);
    end;
  Close(sout);
end.
