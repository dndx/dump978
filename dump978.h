#ifndef DUMP_978_H
#define DUMP_978_H

enum {
    ADS_B_SHORT = 1, // 18 bytes
    ADS_B_LONG = 2, // 34 bytes
    GROUND_UPLINK = 3, // 432 bytes
};

typedef void (*dump978_on_frame_t)(void *data, int frame_type, uint8_t *payload, int rs);

typedef struct {
    dump978_on_frame_t on_frame;
    void *data;
    int used;
    uint64_t offset;
} dump978_t;

typedef struct {
    size_t start; // inclusive
    size_t end; // exclusive
} move_t;

extern int dump978_init(dump978_t **ctx, dump978_on_frame_t cb, void *data);
extern int dump978_destroy(dump978_t *ctx);
extern move_t dump978_process(dump978_t *ctx, char *data, size_t len);

#endif
