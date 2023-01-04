/*  $Header: /dist/CVS/fzclips/src/xsetup.h,v 1.3 2001/08/11 21:08:42 dave Exp $  */

/********************************** xsetup.h **********************************/
/*                                                                            */
/******************************************************************************/
/*                                                                            */
/*        Authors:  BeBe Ly - NASA/Johnson Space Center                       */
/*                  Daniel J. McCoy - University of Houston-Downtown          */
/*                                                                            */
/******************************************************************************/


#include <X11/IntrinsicP.h>
#include <X11/StringDefs.h>
#include <X11/Xutil.h>
#include <X11/keysym.h>
#include <X11/cursorfont.h>

#ifdef XAW3D
#include <X11/Xaw3d/Command.h>
#include <X11/Xaw3d/AsciiText.h>
#include <X11/Xaw3d/Dialog.h>
#include <X11/Xaw3d/MenuButton.h>
#include <X11/Xaw3d/Paned.h>
#include <X11/Xaw3d/SimpleMenu.h>
#include <X11/Xaw3d/SmeBSB.h>
#include <X11/Xaw3d/SmeLine.h>
#include <X11/Xaw3d/Viewport.h>
#include <X11/Xaw3d/List.h>
#include <X11/Xaw3d/Toggle.h>
#else
#include <X11/Xaw/Command.h>
#include <X11/Xaw/AsciiText.h>
#include <X11/Xaw/Dialog.h>
#include <X11/Xaw/MenuButton.h>
#include <X11/Xaw/Paned.h>
#include <X11/Xaw/SimpleMenu.h>
#include <X11/Xaw/SmeBSB.h>
#include <X11/Xaw/SmeLine.h>
#include <X11/Xaw/Viewport.h>
#include <X11/Xaw/List.h>
#include <X11/Xaw/Toggle.h>
#endif  /*End XAW3D*/

/*#include "FileSel.h"*/

