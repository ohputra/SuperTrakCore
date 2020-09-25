/* Automation Studio generated header file */
/* Do not edit ! */
/* DevDetect 1.00.0 */

#ifndef _DEVDETECT_
#define _DEVDETECT_
#ifdef __cplusplus
extern "C" 
{
#endif
#ifndef _DevDetect_VERSION
#define _DevDetect_VERSION 1.00.0
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
#ifdef _SG4
		#include "AsUDP.h"
		#include "AsARCfg.h"
		#include "AsArLog.h"
		#include "AsETH.h"
		#include "AsIOTime.h"
		#include "AsIecCon.h"
#endif
#ifdef _SG3
		#include "AsUDP.h"
		#include "AsARCfg.h"
		#include "AsArLog.h"
		#include "AsETH.h"
		#include "AsIOTime.h"
		#include "AsIecCon.h"
#endif
#ifdef _SGC
		#include "AsUDP.h"
		#include "AsARCfg.h"
		#include "AsArLog.h"
		#include "AsETH.h"
		#include "AsIOTime.h"
		#include "AsIecCon.h"
#endif

/* Constants */
#ifdef _REPLACE_CONST
 #define DEVICE_TYPE_SUPERTRAK_G3 175462291
#else
 #ifndef _GLOBAL_CONST
   #define _GLOBAL_CONST _WEAK const
 #endif
 _GLOBAL_CONST signed long DEVICE_TYPE_SUPERTRAK_G3;
#endif




/* Datatypes and datatypes of function blocks */
typedef struct DeviceDetectInterfaceInternal_t
{	unsigned long socket;
	unsigned short state;
	unsigned short clientPort;
	unsigned short rxLength;
	unsigned short txLength;
	unsigned char rx[64];
	unsigned char tx[64];
	unsigned long errorResetTimer;
	struct UdpRecv fb_recv;
	struct UdpSend fb_send;
	struct AsArLogWrite fb_logWrite;
} DeviceDetectInterfaceInternal_t;

typedef struct DeviceDetectInterface
{
	/* VAR_INPUT (analog) */
	plcstring device[17];
	signed long deviceType;
	signed long deviceState;
	/* VAR (analog) */
	signed long interfaceId;
	struct DeviceDetectInterfaceInternal_t internal;
	/* VAR_INPUT (digital) */
	plcbit enable;
	plcbit allowConfiguration;
} DeviceDetectInterface_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void DeviceDetectInterface(struct DeviceDetectInterface* inst);


#ifdef __cplusplus
};
#endif
#endif /* _DEVDETECT_ */

