#include <linux/fcntl.h>
#include <linux/ioctl.h>
#include <stdio.h>
#include <linux/input.h>
#include <termios.h>
#include <signal.h>
#include <stdlib.h>

static struct termios old, new;
static int inputfd = -1;

#define SEND(a,b,c){ \
    gettimeofday(&ev.time, NULL);\
    ev.type = (a);\
    ev.code = (b);\
    ev.value = (c);\
    write(inputfd, &ev, sizeof(ev));}

void initTermios(void)
{
  tcgetattr(0, &old);
  new = old;
  new.c_lflag &= ~ICANON;
  new.c_lflag &= ~ECHO;
  tcsetattr(0, TCSANOW, &new);
}

void resetTermios(void)
{
  tcsetattr(0, TCSANOW, &old);
}

void help(void)
{
   printf(
      "\n"
      "KOBO PageTurn 1.0 Usage:\n"
      "d, space, enter => forward\n"
      "u => backward\n"
      "q => exit\n"
      "other keys => show this message\n"
      "\n"
   );
}

void terminate(int exitcode) {
   printf("exitcode %d\n", exitcode);
   resetTermios();
   if (inputfd != -1) {
      ioctl(inputfd, EVIOCGRAB, 0);
      close(inputfd);
   }
   exit(0);
}

int main()
{
   struct input_event ev;
   int ch;

   inputfd = open("/dev/input/event0", O_WRONLY, 0);
   if (inputfd == -1) {
      return 1;
   }
   ioctl(inputfd, EVIOCGRAB, 1);
   initTermios();
   signal(SIGINT, terminate);
   signal(SIGTERM, terminate);
   help();

   while (ch = getchar()) {
      switch(ch) {
         case 'q':
            printf("exit\tkeycode=%d\n", ch);
            terminate(0);
         case 'd':
         case ' ':
         case '\r':
         case '\n':
            printf("next\tkeycode=%d\n", ch);
            SEND(EV_KEY, KEY_KATAKANA, 1)
            SEND(EV_SYN, 0,  0)
            SEND(EV_KEY, KEY_KATAKANA, 0)
            SEND(EV_SYN, 0,  0)
            break;
         case 'u':
            printf("prev\tkeycode=%d\n", ch);
            SEND(EV_KEY, KEY_F1, 1)
            SEND(EV_SYN, 0,  0)
            SEND(EV_KEY, KEY_F1, 0)
            SEND(EV_SYN, 0,  0)
            break;
         default:
            printf("unknown\tkeycode=%d\n", ch);
            help();
      }
   }

   terminate(0);
   return 0;
}
